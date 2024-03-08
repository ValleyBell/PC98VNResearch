#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

find . -iname '*.asm' -print | while IFS= read -r f; do
	echo "$f"
	fnew="$f"
	for t in $BASEPATH/common_*.asm ; do
		python3 "$SCRIPTDIR/ScenarioIncludeInsert.py" -p ".." -i "$t" "$fnew" "$fnew" > "/dev/null"
	done
done
