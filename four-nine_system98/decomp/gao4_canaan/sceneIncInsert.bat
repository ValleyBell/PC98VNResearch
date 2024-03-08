@echo off
set BASEPATH=%~dp0
pushd %BASEPATH%..\..
set SCRIPTDIR=%CD%
popd

for /R %%f in (*.asm) do (
	echo %%~nxf
	python "%SCRIPTDIR%\ScenarioIncludeInsert.py" -p ".." -i "%BASEPATH%\header.asm" "%%f" "%%f" > NUL
	for %%t in (%BASEPATH%\footer*.asm) do python "%SCRIPTDIR%\ScenarioIncludeInsert.py" -p ".." -i "%%t" "%%f" "%%f" > NUL
)
