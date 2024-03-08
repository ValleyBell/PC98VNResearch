#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

find DISK_* root -iname '*.asm' -print | while IFS= read -r f; do
	echo "$f"
	#fnew="$(echo "$f" | sed -e 's/\.[Aa][Ss][Mm]$/.txt/')"
	#cp "$f" "$fnew"
	fnew="$f"
	python3 "$SCRIPTDIR/ScenarioIncludeInsert.py" -p ".." -i "$BASEPATH/header.asm" "$fnew" "$fnew" > "/dev/null"
	for t in $BASEPATH/footer*.asm ; do
		python3 "$SCRIPTDIR/ScenarioIncludeInsert.py" -p ".." -i "$t" "$fnew" "$fnew" > "/dev/null"
	done
done
