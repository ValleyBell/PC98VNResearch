#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

find . -iname '*.s' -print | while IFS= read -r fbin; do
	echo "$fbin"
	fasm="$(echo "$fbin" | sed -e 's/\.[Ss]$/.asm/')"
	python3 "$SCRIPTDIR/ScenarioDecompile.py" -e -f "$SCRIPTDIR/Gao4-Font_NoEmoji.txt" "$fbin" "$fasm"
done
