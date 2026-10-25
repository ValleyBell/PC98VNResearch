rem @echo off
set BASEPATH=%~dp0
pushd %BASEPATH%..\..
set SCRIPTDIR=%CD%
popd

cd "MAY-PC98"

rem compile main files
for /R %%f in (*.asm) do @echo %%~nxf & python "%SCRIPTDIR%\ScenarioCompile.py" -f "%SCRIPTDIR%\Gao4-Font_NoEmoji.txt" "%%f" "%%~dpnf.s2"
pause
