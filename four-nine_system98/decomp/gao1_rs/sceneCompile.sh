#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

find . -iname '*.asm' -print | while IFS= read -r fasm; do
	echo "$fasm"
	fbin="$(echo "$fasm" | sed -e 's/\.[Aa][Ss][Mm]$/.lsp/')"
	python3 "$SCRIPTDIR/ScenarioCompile.py" -f "$SCRIPTDIR/Gao4-Font_NoEmoji.txt" "$fasm" "$fbin"
done
