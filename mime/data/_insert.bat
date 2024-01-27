@set PATH=C:\Program Files (x86)\NASM
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\SCN\BATTLE_1.DAT BATTLE_1-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\SCN\Z0000.DAT Z0000-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\SCN\Z0001.DAT Z0001-EN.DAT > NUL
..\NDC U "..\Mime (Special Version).hdi" 0 MIME\Z1000.DAT Z1000-EN.DAT > NUL
@if errorlevel 1 echo "Error patching HDI file!"
@pause
