#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

find . -iname '*.txt' -print0 | while IFS= read -r -d '' fasm; do
	echo "$fbin"
	fbin="$(echo "$fasm" | sed -e 's/\.txt$/.s/')"
	python3 "$SCRIPTDIR/ScenarioCompile.py" -f "$SCRIPTDIR/Gao4-Font_NoEmoji.txt" "$fasm" "$fbin"
done
