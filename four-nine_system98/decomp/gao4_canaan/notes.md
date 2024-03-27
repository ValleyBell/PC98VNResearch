# Various notes

## Game bugs

- `DISK_K\cs18_08.s`:
  - After Rabby connects her notebook to the gate's terminal, the wrong graphics file is loaded.
  - In `loc_17D9` it loads `E018B2.g`, which is the outfit she uses in the future. Correct would be `E018B1.g`.
  - The same issue occours with the next image in `loc_1953`. It loads `E018A2.g` when it should load `E018A1.g`.
