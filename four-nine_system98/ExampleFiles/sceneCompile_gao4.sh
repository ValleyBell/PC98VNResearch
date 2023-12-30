#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

find DISK_* root -iname '*.asm' -print | while IFS= read -r fasm; do
	echo "$fbin"
	fbin="$(echo "$fasm" | sed -e 's/\.[Aa][Ss][Mm]$/.s/')"
	python3 "$SCRIPTDIR/ScenarioCompile.py" -f "$SCRIPTDIR/Gao4-Font_NoEmoji.txt" "$fasm" "$fbin"
done
