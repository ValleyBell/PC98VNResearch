@set PATH=D:\Programme\Python37
for %%f in (R:\CANAAN\*.CAT) do python.exe Unpack.py %%f %%~dpnf.LIB %%~dpfunpack\%%~nf
pause
