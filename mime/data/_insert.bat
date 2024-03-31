@set PATH=C:\Program Files (x86)\NASM
lzss-tool -e -a c4,o4 -n p BATTLE_1-EN.DEC BATTLE_1-EN.DAT
lzss-tool -e -a c4,o4 -n p BATTLE_2-EN.DEC BATTLE_2-EN.DAT
lzss-tool -e -a c4,o4 -n p Z0000-EN.DEC Z0000-EN.DAT
lzss-tool -e -a c4,o4 -n p Z0001-EN.DEC Z0001-EN.DAT
lzss-tool -e -a c4,o4 -n p Z0002-EN.DEC Z0002-EN.DAT
lzss-tool -e -a c4,o4 -n p Z1010-EN.DEC Z1010-EN.DAT
lzss-tool -e -a c4,o4 -n p Z1020-EN.DEC Z1020-EN.DAT
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\SCN\BATTLE_1.DAT BATTLE_1-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\SCN\BATTLE_2.DAT BATTLE_2-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\SCN\Z0000.DAT Z0000-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\SCN\Z0001.DAT Z0001-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\SCN\Z0002.DAT Z0002-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\Z1000.DAT Z1000-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\Z1010.DAT Z1010-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\Z1020.DAT Z1020-EN.DAT > NUL
@if errorlevel 1 echo "Error patching HDI file!"
@pause
