#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

find . -iname '*.asm' -print0 | while IFS= read -r -d '' f; do
	echo "$f"
	fnew="$(echo "$f" | sed -e 's/\.asm$/.txt/')"
	cp "$f" "$fnew"
	python3 "$SCRIPTDIR/ScenarioIncludeInsert.py" -p ".." -i "$BASEPATH/header.asm" "$fnew" "$fnew" > "/dev/null"
	for t in $BASEPATH/footer*.asm ; do
		python3 "$SCRIPTDIR/ScenarioIncludeInsert.py" -p ".." -i "$t" "$fnew" "$fnew" > "/dev/null"
	done
done
