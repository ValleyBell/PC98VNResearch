@set PATH=D:\Programme\Python37
@set SCRIPT=%~dp0ScenarioDec.py
cd /d R:\CANAAN\unpack
for /R %%f in (*.S) do python.exe %SCRIPT% %%f %%fcn
pause
