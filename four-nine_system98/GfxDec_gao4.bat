@set SCRIPT=%~dp0Graphics2Pi.py
cd /d R:\CANAAN
for /R %%f in (*.g) do python.exe %SCRIPT% "%%f" "%%~dpnf.pi" && del "%%f"
pause
