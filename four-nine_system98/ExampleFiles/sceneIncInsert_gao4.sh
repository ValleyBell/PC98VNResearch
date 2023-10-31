#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

find . -iname '*.asm' -print0 | while IFS= read -r -d '' f; do
	echo "$f"
	for t in $BASEPATH/footer*.asm ; do
		fnew="$(echo "$f" | sed -e 's/\.asm/.txt/')"
		python3 "$SCRIPTDIR/ScenarioIncludeInsert.py" -p ".." -i "$t" "$f" "$fnew" > "/dev/null"
		ret=$?
		[ $ret -eq 0 ] && break
	done
	python3 "$SCRIPTDIR/ScenarioIncludeInsert.py" -p ".." -i "$BASEPATH/header.asm" "$fnew" "$fnew" > "/dev/null"
done
