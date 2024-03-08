@echo off
set BASEPATH=%~dp0
pushd %BASEPATH%..\..
set SCRIPTDIR=%CD%
popd

for /R %%f in (*.asm) do (
	echo %%~nxf
	for %%t in (%BASEPATH%\common_*.asm) do python "%SCRIPTDIR%\ScenarioIncludeInsert.py" -p ".." -i "%%t" "%%f" "%%f" > NUL
)
