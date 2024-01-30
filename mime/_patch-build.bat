@set PATH=C:\Program Files (x86)\NASM
nasm -f bin -o MIME-ASC.EXE -l MIME-ASC.lst "MIME-ASC.asm"
NDC U "Mime (Special Version).hdi" 0 MIME\MIME.EXE MIME-ASC.EXE > NUL
@if errorlevel 1 echo "Error patching HDI file!"
@pause
