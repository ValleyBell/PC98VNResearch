#!/usr/bin/env python3
"""
hhg-mdr.py: Extract Heart Heat Girls MDR script files.
Made by Fuzion
License: GPL-2.0-or-later

HHG MDR format (reverse-engineered from EXDD.COM and MAX.COM):
  1. MAXPACK container = Okumura / Haruyasu Yoshizaki LZSS. See maxpack.py
     for the container layout and the ring-buffer init pattern. The LZSS
     stream starts at file offset 18, not 16.
  2. After decompression, every byte is XOR'd with 0xFF to recover the
     plaintext. This is an additional obfuscation layer applied to the
     original data before LZSS compression.
  3. The plaintext is what MAX.COM's script interpreter (0x3148) reads
     directly: Shift-JIS dialogue, ASCII filenames (twb.vdf, hg05.uso,
     hhgwin.pdd, ...), @-commands (@cf / @v / @h / @s / @o / @q / @a /
     @w / @m for face, position, style, outline, quality, animation,
     wait, memorize-position), and binary opcodes 0x00-0x0b (0x00=end,
     0x02=xy, 0x04=wait-for-input, 0x0d=CR, ...).
     
     MAX.COM identifies itself as "Adventure Scenario Driver for
     PC-9801 Ver0.92" by PANDA HOUSE / Cat's Pro, 1993.
  Note: 0099.MDR is stored uncompressed (no MAXPACK wrapper); it's the
  only MDR file loaded directly without going through LZSS. It was
  seemingly intentional (MAX.COM has special handling for 0099 in its
  binary) but I have no idea why.

Usage:
  Low-level (decoded plaintext <-> binary):
    python hhg-mdr.py decode <input.MDR>              # writes <input>.dat (plaintext)
    python hhg-mdr.py decode <input.MDR> <out>
    python hhg-mdr.py encode <input.dat>              # writes <input>.MDR  (MAXPACK)
    python hhg-mdr.py encode <input.dat> <out>
    python hhg-mdr.py encode <input.dat> <out> -r     # raw (no MAXPACK, for 0099.MDR)

  Text round-trip (for safely editing dialogue):
    python hhg-mdr.py dump   <input.MDR> <edits.txt>  # dumps every text run to UTF-8
    python hhg-mdr.py apply  <input.MDR> <edits.txt> <out.MDR>

  Listing:
    python hhg-mdr.py text   <input.MDR>              # prints runs to stdout
    python hhg-mdr.py text   <input.MDR> <out.txt>
"""

import sys
from pathlib import Path
import maxpack


def decode(src: Path) -> bytes:
    """
    Return the plaintext bytes of an MDR file.

    MAXPACK-wrapped files get LZSS-decompressed first; files that lack the
    wrapper (only 0099.MDR in HHG) are passed through. Either
    way, the final step is XORing every byte with 0xFF.
    """
    data = src.read_bytes()
    if data[:8] == maxpack.MAGIC:
        data = maxpack.decompress(data)
    return bytes(b ^ 0xFF for b in data)


def encode(plaintext: bytes, raw: bool = False) -> bytes:
    """
    Inverse of decode(). XOR the plaintext with 0xFF, then either MAXPACK-
    compress it (default) or return it as-is (raw=True, if any other files
    like 0099.MDR exist). The result is a byte string ready to write back
    to disk as a replacement MDR.
    """
    xored = bytes(b ^ 0xFF for b in plaintext)
    if raw:
        return xored
    return maxpack.compress(xored)


def extract_runs(plaintext: bytes) -> list[tuple[int, int, str]]:
    """
    Walk the plaintext and return every contiguous text run as
    (offset, byte_length, decoded_string) tuples.

    A text run is a maximal contiguous sequence of:
      - printable ASCII (0x20..0x7e), OR
      - valid 2-byte Shift-JIS characters (lead in 0x81..0x9f or 0xe0..0xfc
        followed by trail in 0x40..0xfc except 0x7f), OR
      - carriage-return bytes (0x0d), which the MAX.COM text dispatcher
        treats as a line-break opcode inside dialogue.

    Everything else (binary control bytes 0x00..0x1f except 0x0d, 0x7f..0x80,
    bare 0xa0, 0xfd..0xff) terminates a run. CR bytes appear in the decoded
    string as literal '\\r' characters; the dump/apply codepaths escape them
    as the two-char sequence "\\r" so text editors don't mangle them.

    Runs of less than 2 characters are skipped as noise. This should be a
    reasonably accurate heuristic.
    """
    runs = []
    i = 0
    n = len(plaintext)
    while i < n:
        start = i
        byte_chars: list[bytes] = []
        while i < n:
            b = plaintext[i]
            if (0x81 <= b <= 0x9f or 0xe0 <= b <= 0xfc) and i + 1 < n:
                nxt = plaintext[i + 1]
                if 0x40 <= nxt <= 0xfc and nxt != 0x7f:
                    byte_chars.append(plaintext[i:i + 2])
                    i += 2
                    continue
            if 0x20 <= b <= 0x7e or b == 0x0d:
                byte_chars.append(bytes([b]))
                i += 1
                continue
            break
        if byte_chars and len(byte_chars) >= 2:
            try:
                text = b"".join(byte_chars).decode("shift-jis")
                runs.append((start, i - start, text))
            except UnicodeDecodeError:
                pass
        if i == start:
            i += 1
    return runs


def escape_text(s: str) -> str:
    """
    Escape a decoded text run for writing to the dump file.

    Backslash and CR (the MDR line-break opcode) get C-style escapes so they
    survive the round-trip through a text editor unchanged. Tab would be a
    column separator collision but it never appears inside a run because 0x09
    is not allowed in the run alphabet.
    """
    return s.replace("\\", "\\\\").replace("\r", "\\r")


def unescape_text(s: str) -> str:
    """Inverse of escape_text(). Unknown \\X escapes are left intact."""
    out = []
    i = 0
    while i < len(s):
        if s[i] == "\\" and i + 1 < len(s):
            c = s[i + 1]
            if c == "r":
                out.append("\r")
                i += 2
                continue
            if c == "\\":
                out.append("\\")
                i += 2
                continue
        out.append(s[i])
        i += 1
    return "".join(out)


def classify_run(text: str) -> str:
    """Short type hint for the dump file. Purely informational, not even checked on apply."""
    if text.startswith("#"):
        return "label"
    if text.startswith("@"):
        return "cmd"
    lower = text.lower()
    for ext in (".vdf", ".uso", ".pdd", ".mdr", ".dat", ".pcm", ".com"):
        if lower.endswith(ext):
            return "file"
    # contains any non-ASCII character -> Japanese dialogue
    if any(ord(c) > 0x7e for c in text):
        return "text"
    return "ascii"


def extract_text(plaintext: bytes) -> list[tuple[int, str]]:
    """Backward-compatible wrapper: (offset, text) without lengths."""
    return [(off, text) for off, _ln, text in extract_runs(plaintext)]


def cmd_decode(src: Path, dst: Path):
    plain = decode(src)
    dst.write_bytes(plain)
    print(f"  decode  {src.name:16s}  {len(plain):,} bytes -> {dst}")


def cmd_encode(src: Path, dst: Path, raw: bool):
    plaintext = src.read_bytes()
    packed = encode(plaintext, raw=raw)
    dst.write_bytes(packed)
    tag = "raw" if raw else "MAXPACK"
    print(f"  encode  {src.name:16s}  {len(plaintext):,} -> {len(packed):,} bytes ({tag}) -> {dst}")


def cmd_text(src: Path, dst):
    plain = decode(src)
    runs = extract_text(plain)
    lines = [f"{off:04X}  {run}" for off, run in runs]
    output = "\n".join(lines) + "\n"
    if dst is None:
        sys.stdout.write(output)
    else:
        Path(dst).write_text(output, encoding="utf-8")
        print(f"  text    {src.name:16s}  {len(runs):,} runs -> {dst}")


DUMP_HEADER = """\
# hhg-mdr.py text dump from {src}
# Decoded plaintext length: {size} bytes
#
# Each non-comment, non-blank line is:   OFFSET<TAB>TYPE<TAB>TEXT
#   - OFFSET is hex, refers to the decoded plaintext. Do not change it.
#   - TYPE is a hint, ignored on apply. One of: text, cmd, label, file, ascii.
#   - TEXT is UTF-8. Edit freely; length may change (the game tolerates it
#     for the dialogue region). You cannot introduce characters that do not
#     encode in Shift-JIS (standard JIS X 0208 + ASCII).
#
# Escapes inside TEXT:
#   \\r   -> carriage-return (0x0d), the in-dialogue line break opcode.
#           Add or remove these to control line-wrapping in dialogue boxes.
#   \\\\   -> literal backslash
#   _    -> Not an escape, but it maps to half-width space
#
# Editing label/file/cmd runs is legal but usually unwise: labels are
# referenced by name from other MDR files, and filenames point to on-disk
# assets. Dialogue ('text' rows) is the normal thing to edit.
#
# Lines you don't want to change can be left alone OR deleted; only edits
# that actually differ from the original file are applied, everything
# else is left untouched.
#
# Apply with:
#   python hhg-mdr.py apply {src} <this-file> <out.MDR>
#
"""


def _parse_offset(s: str) -> int:
    """Parse a hex offset with or without a 0x prefix. Raises ValueError on bad input."""
    s = s.strip()
    if s.lower().startswith("0x"):
        s = s[2:]
    return int(s, 16)


# Some opcodes use a 2-byte offset in the file as their operand. If the script
# length is edited, these offsets become garbage, which will probably make the
# game crash/freeze. These methods adjust the in-script pointers to match new
# line lengths. So much simpler than Possessioner, ugh.
# Add more opcodes here if additional pointer-taking instructions are discovered.
ABSOLUTE_POINTER_OPCODES = {0x16}


def find_absolute_pointers(plain: bytes) -> list[tuple[int, int]]:
    """
    Scan plaintext for bytes in ABSOLUTE_POINTER_OPCODES whose following 2-byte
    little-endian word is a plausible in-file offset. Returns [(src_pos, target), ...].

    Heuristic: accept only when target is > 0 and < len(plaintext). This will
    occasionally have a false-positive on a 0x16 byte that's actually part of a
    multi-byte structure (e.g. another command's operand), but the fixup logic
    only rewrites pointers whose target would MOVE, and only by the exact delta
     induced by the surrounding edits, so a false positive on an unrelated
    0x16 is a no-op unless its 'target' happens to cross an edit boundary.
    """
    result = []
    n = len(plain)
    for i in range(n - 2):
        if plain[i] in ABSOLUTE_POINTER_OPCODES:
            tgt = plain[i + 1] | (plain[i + 2] << 8)
            if 0 < tgt < n:
                result.append((i, tgt))
    return result


def shift_old_to_new(old_pos: int, replacements: list[tuple[int, int, bytes]]) -> int:
    """
    Map a position in the original plaintext to its position in the edited
    plaintext, given a list of (offset, old_length, new_bytes) replacements.

    Replacements are assumed non-overlapping. If old_pos falls inside a
    replacement's old range, it snaps to the start of that replacement (i.e.
    treats the whole original span as a unit). Replacements that are entirely
    before old_pos shift it by (new_len - old_len).
    """
    new_pos = old_pos
    for off, old_len, new_bytes in replacements:
        if off + old_len <= old_pos:
            new_pos += len(new_bytes) - old_len
        elif off <= old_pos < off + old_len:
            # Inside an edited span: snap to the (already-shifted) start of
            # the edit. This is a rough fallback; in practice pointers should
            # never land mid-run.
            new_pos = shift_old_to_new(off, replacements)
            break
    return new_pos


def is_inside_replacement(pos: int, replacements: list[tuple[int, int, bytes]]) -> bool:
    for off, old_len, _ in replacements:
        if off <= pos < off + old_len:
            return True
    return False


def cmd_dump(src: Path, dst: Path):
    plain = decode(src)
    runs = extract_runs(plain)
    lines = [DUMP_HEADER.format(src=src.name, size=len(plain))]
    for off, _ln, text in runs:
        lines.append(f"{off:04X}\t{classify_run(text)}\t{escape_text(text)}")
    lines.append("")  # trailing newline
    dst.write_text("\n".join(lines), encoding="utf-8")
    print(f"  dump    {src.name:16s}  {len(runs):,} runs -> {dst}")


def cmd_apply(src_mdr: Path, txt: Path, dst_mdr: Path):
    # Decode the source MDR and remember the original runs by offset
    plain = bytearray(decode(src_mdr))
    original_runs = {off: (ln, text) for off, ln, text in extract_runs(bytes(plain))}

    # Parse the edited text file
    edits: list[tuple[int, str]] = []
    lineno = 0
    for raw_line in txt.read_text(encoding="utf-8").splitlines():
        lineno += 1
        if not raw_line.strip() or raw_line.lstrip().startswith("#"):
            continue
        parts = raw_line.split("\t")
        if len(parts) < 2:
            print(f"  warning: line {lineno} has no tab separator, skipped")
            continue
        off_str = parts[0]
        # TYPE column is optional (and ignored); text is the rest
        if len(parts) >= 3:
            text = "\t".join(parts[2:])
        else:
            text = parts[1]
        text = unescape_text(text)
        try:
            off = _parse_offset(off_str)
        except ValueError:
            print(f"  warning: line {lineno} has invalid offset {off_str!r}, skipped")
            continue
        edits.append((off, text))

    # Validate and encode each edit; compute byte replacements
    replacements: list[tuple[int, int, bytes]] = []  # (offset, old_length, new_bytes)
    unchanged = 0
    missing = 0
    encoding_errors = 0

    for off, new_text in edits:
        if off not in original_runs:
            print(f"  warning: no text run at offset 0x{off:04X}, skipped")
            missing += 1
            continue
        old_len, old_text = original_runs[off]
        if new_text == old_text:
            unchanged += 1
            continue
        try:
            new_bytes = new_text.encode("shift-jis")
        except UnicodeEncodeError as e:
            print(f"  error: offset 0x{off:04X}: {new_text!r} is not representable in Shift-JIS ({e})")
            encoding_errors += 1
            continue
        replacements.append((off, old_len, new_bytes))

    if encoding_errors:
        print(f"  aborting: {encoding_errors} text run(s) could not be encoded to Shift-JIS")
        sys.exit(2)

    # Snapshot of the original plaintext: used for pointer-fixup lookups below
    # BEFORE any bytes shift around.
    original_plain = bytes(plain)

    # Apply replacements in DESCENDING offset order so earlier offsets stay valid
    replacements_sorted = sorted(replacements, key=lambda r: r[0], reverse=True)
    for off, old_len, new_bytes in replacements_sorted:
        plain[off:off + old_len] = new_bytes

    # --- Pointer fixup pass ---
    # Find every absolute-offset pointer in the ORIGINAL plaintext, then for
    # each one, compute where it lives now and what its target should now be.
    # Only rewrites pointers whose source is still intact (not clobbered by an
    # edit) AND whose target would actually move.
    pointers = find_absolute_pointers(original_plain)
    pointer_fixups = 0
    pointer_clobbered = 0
    for src_pos, old_tgt in pointers:
        if is_inside_replacement(src_pos, replacements):
            pointer_clobbered += 1
            continue
        new_src = shift_old_to_new(src_pos, replacements)
        new_tgt = shift_old_to_new(old_tgt, replacements)
        if new_tgt == old_tgt:
            continue  # target didn't move, nothing to do
        # Sanity-check: the opcode byte should still be where we expect it to be
        if new_src >= len(plain) or plain[new_src] not in ABSOLUTE_POINTER_OPCODES:
            print(f"  warning: pointer at 0x{src_pos:04X} displaced unexpectedly; skipping fixup")
            continue
        plain[new_src + 1] = new_tgt & 0xff
        plain[new_src + 2] = (new_tgt >> 8) & 0xff
        pointer_fixups += 1

    # Re-encode and write
    # 0099.MDR is the only raw file in HHG, so honor its name here
    raw = src_mdr.name.lower() == "0099.mdr" or src_mdr.suffix.lower() != ".mdr"
    packed = encode(bytes(plain), raw=raw)
    dst_mdr.write_bytes(packed)

    changed = len(replacements)
    total_old = sum(old_len for _, old_len, _ in replacements)
    total_new = sum(len(b) for _, _, b in replacements)
    delta = total_new - total_old
    print(f"  apply   {src_mdr.name:16s}  {changed} edit(s) applied, "
          f"{unchanged} unchanged, {missing} missing "
          f"(delta {delta:+d} bytes), "
          f"{pointer_fixups} pointer(s) adjusted -> {dst_mdr}")
    if pointer_clobbered:
        print(f"  note: {pointer_clobbered} pointer(s) inside edited regions were not fixed "
              f"(they were overwritten by edits)")


def main():
    argv = sys.argv[1:]
    raw_flag = False
    if "-r" in argv:
        raw_flag = True
        argv.remove("-r")
    if "--raw" in argv:
        raw_flag = True
        argv.remove("--raw")

    if len(argv) < 2:
        print(__doc__)
        sys.exit(1)
    cmd = argv[0].lower()
    src = Path(argv[1])
    if not src.exists():
        print(f"Error: {src} not found")
        sys.exit(1)
    if cmd == "decode":
        dst = Path(argv[2]) if len(argv) > 2 else src.with_suffix(".dat")
        cmd_decode(src, dst)
    elif cmd == "encode":
        dst = Path(argv[2]) if len(argv) > 2 else src.with_suffix(".MDR")
        cmd_encode(src, dst, raw=raw_flag)
    elif cmd == "text":
        dst = argv[2] if len(argv) > 2 else None
        cmd_text(src, dst)
    elif cmd == "dump":
        dst = Path(argv[2]) if len(argv) > 2 else src.with_suffix(".txt")
        cmd_dump(src, dst)
    elif cmd == "apply":
        if len(argv) < 4:
            print("Usage: hhg-mdr.py apply <source.MDR> <edited.txt> <out.MDR>")
            sys.exit(1)
        txt = Path(argv[2])
        out = Path(argv[3])
        if not txt.exists():
            print(f"Error: {txt} not found")
            sys.exit(1)
        cmd_apply(src, txt, out)
    else:
        print(f"Unknown command: {cmd!r}")
        sys.exit(1)


if __name__ == "__main__":
    main()
