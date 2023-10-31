#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

find . -iname '*.s' -print0 | while IFS= read -r -d '' fbin; do
	echo "$fbin"
	fasm="$(echo "$fbin" | sed -e 's/\.s$/.asm/')"
	python3 "$SCRIPTDIR/ScenarioDecompile.py" -e -f "$SCRIPTDIR/Gao4-Font_NoEmoji.txt" "$fbin" "$fasm"
done
