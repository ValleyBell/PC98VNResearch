for %%f in (R:\GAO3\*.CAT) do python "%~dp0sys98_packer.py" -x "%%f" "%%~dpfunpack\%%~nf"
pause
