# Adv98V Engine

## Folder contents

- [Dengeki Nurse](./DengekiNurse) research information + English translation patches
  - *Note:* Also contains a disassembly + English translation of AdvBIOS v0.54 (compatible with Adv98V v1.70.54).
- [Marine Philt](./MarinePhilt) research information

## TCM executables

Adv98 makes use of tiny executables with `.TCM` extension to run custom code that can't be replicated using its scripting language.
These executables have no header and immediately begin with executable code.

The general workflow of using them in MES scripts goes like this:

1. Load a TCM file using: `load-mem "file.tcm" load-offset` ("load-offset" is the absolute address inside the script's data memory segment.)
    - Example for Dengeki Nurse's opening: `load-mem "cmd\nrsopen.tcm" 5760`
2. Call the TCM file using `exec-mem load-offset parameter`
    - This will at first load the "parameter" value into register BX.
    - Then it calls the TCM code using its load-offset. (register state: CS = DS = ES = data memory segment, PC = load-offset)
    - TCM files usually start with a bit of code that changes the CS and PC registers so that it appears like the TCM file is executed from offset 0.  
      This allows for proper absolute addressing inside the TCM code with the assumption that the TCM file begins at offset 0.
    - Example for Dengeki Nurse's opening: `exec-mem 5760 1`
      - set `BX = 1`
      - set `DS = dataseg, ES = dataseg`
      - `call dataseg:1680h`
        - inside the TCM: set `CS = dataseg+168h`

## Notes

- The base executables (`ADV98V.OVL`, `ADVBIOS.OVL`, `INSTH.EXE`) are compressed using EXEPACK and then encrypted using 3 levels of encryption.
  - Most of them are encrypted using 3 levels of "TC0" encryption, which is found commonly in games developed/published by Ides.
    - These executables can be decrypted using [adv98\_dec](https://github.com/ValleyBell/ExtractorsDecoders#adv98_dec).
    - The encryption is moderately simple: It applies a changing XOR key to each byte and then bit-rotates it twice to the right.
    - The disassembled TC0 decryption code can be found in [ADVBIOS-decrypt.asm](DengekiNurse/ADVBIOS-decrypt.asm).
  - Later games have the executables encrypted using, TC0, PIYO, TC0 in that order.
    - The "PIYO" encryption is found more commonly in PANDA HOUSE games and can be decrypted using [piyo\_dec](https://github.com/ValleyBell/ExtractorsDecoders#piyo_dec).
- The AdvBIOS executable (usually called `ADVBIOS.OVL`, `ADVBIOS.EXE` or `ADVBIOS.OV1`) contains a "Confidentiality Notice" in all releases.  
  - The message is encrypted by XORing it with `0xFF` and can be found in the disassembly under `aCondifentNote`.
  - There is an unused function that (1) decrypts and prints the message and (2) checks whether or not the message was modified by comparing the decrypted text with a 16-bit checksum. When the checksum check fails, it shows an error message and denies running the program.
  - There is an additional function (`VerifyUserName` in the disassembly) that checks, that the user name inside the "Confidentiality Notice" text matches a separate unencrypted copy of the user name. (labelled `aUserName` in the disassembly)  
    This function is used (!) and gets called when loading the executable.  
    When the check fails, it also shows an error message and stops running the program.
  - There is a more verbose description and text examples related to the "Confidentiality Notice" on the respective page on [The Cutting Room Floor](https://tcrf.net/The_Cutting_Room_Floor:Common_Things#PC-98).
