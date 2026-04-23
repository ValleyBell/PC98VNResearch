#!/usr/bin/env python3
"""
maxpack.py: Decompress and recompress MAXPACK/LZSS files.
Written for Heart Heat Girls but probably works for other games too.
Made by Fuzion
License: GPL-2.0-or-later

Usage:
  python maxpack.py decompress <input>            # writes <input>.out
  python maxpack.py decompress <input> <output>
  python maxpack.py compress   <input>            # writes <input>.mpk
  python maxpack.py compress   <input> <output>
  python maxpack.py roundtrip  <input>            # decompress -> compress -> verify

Bulk examples (shell):
  for f in *.MDR; do python maxpack.py decompress "$f"; done
  for f in *.out; do python maxpack.py compress   "$f"; done

MAXPACK header (18 bytes):
  [0-8]    Magic      b'MAXPACK\x00'
  [8-10]   uint16 LE  Uncompressed size
  [10-12]  uint16 LE  Compressed payload size (bytes after the 18-byte header)
  [12-14]  uint16     0x0000  (padding / flags)
  [14-16]  uint16 LE  Repeat of uncompressed size (checkword probably)
  [16-18]  uint16     0x0000  (padding. EXDD.COM's file loader reads the first 10
                               bytes for the magic check, then its setup function
                               does ADD SI, 8 after reading the remaining bytes)

Compression: Okumura / Haruyasu Yoshizaki LZSS (same init pattern as LHA/LZARI).
  Window   : 4096 bytes (12-bit offset)
  Ring init: 13-byte runs of each value 0..255, then 0..255, then 255..0, then
             128 zero bytes, then 110 ASCII spaces, totalling 4078 bytes. The
             last 18 slots (0xfee..0xfff) are the reserved write area and get
             overwritten before being read. Reverse-engineered from EXDD.COM's
             setup function at file offset 0x04c7.
  Ring pos : starts at WINDOW - MAX_MATCH = 4078 (0xfee)
  Min match: 3 bytes
  Max match: 18 bytes
  Flag byte: LSB-first;  1 = literal byte,  0 = back-reference
  Back-ref : 2 bytes: lo | ((hi & 0xF0) << 4) = offset,  (hi & 0x0F) + 3 = length

XOR layer:
  On top of LZSS, every byte of the original plaintext is XOR'd with 0xFF before
  compression. `decompress()` returns the raw (still-XOR'd) bytes; the caller is
  responsible for the final XOR pass. hhg-mdr.py does this.

Self-extension note:
  When (ring - offset) % WINDOW < match_length, the decompressor starts
  reading bytes it just wrote, repeating the output with period
  gap = (ring - offset) % WINDOW.  this was a bug, but now find_match() handles
  this explicitly.
"""

import sys
import struct
from pathlib import Path

MAGIC      = b"MAXPACK\x00"
WINDOW     = 4096
MIN_LEN    = 3
MAX_LEN    = 18
RING_START = WINDOW - MAX_LEN   # 4078 = 0xfee
HEADER_LEN = 18                 # LZSS stream starts at file offset 18


def build_initial_ring() -> bytearray:
    """
    Haruyasu Yoshizaki LZSS ring initialization, matching EXDD.COM's setup
    routine at file offset 0x04c7. Produces exactly 4078 bytes of content;
    slots 0xfee..0xfff stay zero (they're the reserved write area and get
    overwritten before any back-reference can read them).
    """
    buf = bytearray(WINDOW)
    p = 0
    for val in range(256):           # 13 copies of each byte value
        for _ in range(13):
            buf[p] = val; p += 1
    for val in range(256):           # 0..255 ascending
        buf[p] = val; p += 1
    for val in range(255, -1, -1):   # 255..0 descending
        buf[p] = val; p += 1
    for _ in range(128):             # 128 zeros
        buf[p] = 0; p += 1
    for _ in range(110):             # 110 ASCII spaces
        buf[p] = 0x20; p += 1
    assert p == RING_START
    return buf
# This is such a weird pattern... Why?

# -- Decompress ----------------------------------------------------------------

def decompress(data: bytes) -> bytes:
    if len(data) < HEADER_LEN or data[:8] != MAGIC:
        raise ValueError("Not a MAXPACK file (bad magic)")

    uncomp_size = struct.unpack_from("<H", data, 8)[0]
    buf  = build_initial_ring()
    ring = RING_START
    out  = bytearray()
    pos  = HEADER_LEN

    while pos < len(data) and len(out) < uncomp_size:
        flags = data[pos]; pos += 1
        for _ in range(8):
            if len(out) >= uncomp_size or pos >= len(data):
                break
            if flags & 1:                               # literal
                b = data[pos]; pos += 1
                out.append(b); buf[ring] = b; ring = (ring + 1) % WINDOW
            else:                                       # back-reference
                if pos + 1 >= len(data): break
                lo = data[pos]; pos += 1
                hi = data[pos]; pos += 1
                offset = lo | ((hi & 0xF0) << 4)
                length = (hi & 0x0F) + MIN_LEN
                for i in range(length):
                    if len(out) >= uncomp_size: break
                    b = buf[(offset + i) % WINDOW]
                    out.append(b); buf[ring] = b; ring = (ring + 1) % WINDOW
            flags >>= 1

    if len(out) != uncomp_size:
        raise ValueError(f"Size mismatch: got {len(out)}, expected {uncomp_size}")
    return bytes(out)


# -- Compress ------------------------------------------------------------------

def _find_match(raw: bytes, raw_pos: int, buf: bytearray, ring: int) -> tuple:
    """
    Find longest match in the ring buffer for raw[raw_pos:].

    Self-extension: if gap = (ring - start) % WINDOW < length, the
    decompressor loops back on its own output with period `gap`.
    We detect this and verify the repeating tail explicitly.
    """
    remaining = len(raw) - raw_pos
    look      = min(remaining, MAX_LEN)
    if look < MIN_LEN:
        return 0, 0

    first_byte = raw[raw_pos]
    best_len   = MIN_LEN - 1
    best_off   = 0

    for start in range(WINDOW):
        if buf[start] != first_byte:
            continue

        gap = (ring - start) % WINDOW  # always in [1, WINDOW]

        if gap >= look:
            # No self-extension within the match, fast static check
            length = 1
            while length < look and buf[(start + length) % WINDOW] == raw[raw_pos + length]:
                length += 1
        else:
            # Self-extension: first `gap` bytes from original buffer,
            # then output repeats with period `gap`.
            length = 1
            while length < gap and buf[(start + length) % WINDOW] == raw[raw_pos + length]:
                length += 1
            if length == gap:
                # Verify the repeating tail
                while length < look and raw[raw_pos + length % gap] == raw[raw_pos + length]:
                    length += 1

        if length > best_len:
            best_len = length
            best_off = start
            if best_len == look:
                break

    return (best_off, best_len) if best_len >= MIN_LEN else (0, 0)


def compress(raw: bytes) -> bytes:
    buf     = build_initial_ring()
    ring    = RING_START
    payload = bytearray()
    raw_pos = 0

    while raw_pos < len(raw):
        tokens = []
        flag   = 0

        for bit in range(8):
            if raw_pos >= len(raw):
                break
            offset, length = _find_match(raw, raw_pos, buf, ring)

            if length >= MIN_LEN:
                tokens.append((False, offset, length))
                for i in range(length):
                    buf[ring] = raw[raw_pos + i]; ring = (ring + 1) % WINDOW
                raw_pos += length
            else:
                b = raw[raw_pos]
                tokens.append((True, b))
                flag |= (1 << bit)
                buf[ring] = b; ring = (ring + 1) % WINDOW
                raw_pos += 1

        payload.append(flag)
        for token in tokens:
            if token[0]:
                payload.append(token[1])
            else:
                offset, length = token[1], token[2]
                lo = offset & 0xFF
                hi = ((offset >> 4) & 0xF0) | ((length - MIN_LEN) & 0x0F)
                payload.append(lo); payload.append(hi)

    uncomp_size = len(raw)
    # 18-byte header: magic (8), uncomp_size, comp_size, flags, uncomp_size, pad
    header = struct.pack("<8sHHHHH", MAGIC, uncomp_size, len(payload), 0, uncomp_size, 0)
    return header + bytes(payload)


# -- CLI -----------------------------------------------------------------------

def _fmt(src_size, dst_size):
    return f"{src_size:>7,} → {dst_size:>7,} bytes  ({dst_size*100//src_size}% of original)"

def cmd_decompress(src: Path, dst: Path):
    raw = src.read_bytes()
    out = decompress(raw)
    dst.write_bytes(out)
    print(f"  decompress  {src.name:35s}  {_fmt(len(raw), len(out))}")

def cmd_compress(src: Path, dst: Path):
    raw = src.read_bytes()
    out = compress(raw)
    dst.write_bytes(out)
    print(f"  compress    {src.name:35s}  {_fmt(len(raw), len(out))}")

def cmd_roundtrip(src: Path):
    raw      = src.read_bytes()
    decompd  = decompress(raw)
    recompd  = compress(decompd)
    decompd2 = decompress(recompd)
    if decompd == decompd2:
        print(f"  ✓  {src.name}  roundtrip OK  "
              f"(recompressed: {len(recompd):,} bytes / {len(recompd)*100//len(decompd)}% "
              f"of {len(decompd):,}; original was {len(raw):,})")
    else:
        for i, (a, b) in enumerate(zip(decompd, decompd2)):
            if a != b:
                print(f"  ✗  MISMATCH at byte {i:#x}: expected {a:#04x} got {b:#04x}")
                break
        sys.exit(1)

def main():
    if len(sys.argv) < 3:
        print(__doc__); sys.exit(1)
    cmd = sys.argv[1].lower()
    src = Path(sys.argv[2])
    if not src.exists():
        print(f"Error: {src} not found"); sys.exit(1)

    if cmd == "decompress":
        dst = Path(sys.argv[3]) if len(sys.argv) > 3 else src.with_suffix(".out")
        cmd_decompress(src, dst)
    elif cmd == "compress":
        dst = Path(sys.argv[3]) if len(sys.argv) > 3 else src.with_suffix(".mpk")
        cmd_compress(src, dst)
    elif cmd == "roundtrip":
        cmd_roundtrip(src)
    else:
        print(f"Unknown command: {cmd!r}"); sys.exit(1)

if __name__ == "__main__":
    main()
