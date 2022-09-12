@set PATH=D:\Programme\Python37
@set SCRIPT=%~dp0Unpack.py
cd /d R:\GAO3
for %%f in (*.CAT) do python.exe %SCRIPT% %%f %%~dpnf.LIB %%~dpfunpack\%%~nf
pause
