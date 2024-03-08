# Decompilig Gao Gao! 4th: Canaan

## Unpacking the data

1. create a new folder `CANAAN`
2. unpack `DISK_J.LIB`, `DISK_K.LIB` and `DISK_L.LIB` into separate subfolders there
3. create a `root` subfolder and copy the `.S` files from the game's root folder into it

## Decompiling

1. open a terminal in the `CANAAN` folder
2. run the `sceneDecompile_gao4.sh` script by calling it using its full path
3. run the `sceneIncInsert_gao4.sh` script by calling it using its full path

## Generate a text table with all texts

1. open a terminal in the `CANAAN` folder
2. run the `scene2tsv_gao4.sh` script by calling it using its full path

## Run the text table through Google Translate

1. run `python3 tsvTranslate.py input.tsv output.tsv`

## Reinsert all text into the decompiled scripts

1. run `python3 ScenarioTsvReinsert.py -c texts.tsv -i CANAAN/ -o CANAAN-EN/`

## Recompiling

1. open a terminal in the `CANAAN-EN` folder
2. copy `header.asm` and all `footer_*.asm` files into the folder
3. run the `sceneCompile_gao4.sh` script by calling it using its full path
