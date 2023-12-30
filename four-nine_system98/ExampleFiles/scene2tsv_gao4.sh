#!/bin/sh
BASEPATH="$(dirname "$(realpath "$0")")"
SCRIPTDIR="$(dirname "$BASEPATH")"

python3 "$SCRIPTDIR/ScenarioTsvDump.py" -o "CS.tsv"        DISK_J/cs*.asm DISK_L/cs1*.asm DISK_K/cs*.asm DISK_L/cs2*.asm
python3 "$SCRIPTDIR/ScenarioTsvDump.py" -o "misc.tsv"      "DISK_J/cannan.asm" "DISK_J/config.asm" "DISK_J/ending.asm" "DISK_J/nsel.asm" "DISK_J/omoide.asm" "root/OPEN.asm" "DISK_J/prolog.asm" "DISK_J/prologue.asm" "DISK_J/ss.asm" "DISK_J/staff.asm"
python3 "$SCRIPTDIR/ScenarioTsvDump.py" -o "nchan.tsv"     "DISK_J/nchan.asm"
python3 "$SCRIPTDIR/ScenarioTsvDump.py" -o "wakuwaku.tsv"  "root/WAKUWAKU.asm"
