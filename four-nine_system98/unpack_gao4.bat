for %%f in (R:\CANAAN\*.CAT) do python "%~dp0sys98_packer.py" -x "%%f" "%%~dpfunpack\%%~nf"
pause
