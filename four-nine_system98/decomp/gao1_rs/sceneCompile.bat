@echo off
set BASEPATH=%~dp0
pushd %BASEPATH%..\..
set SCRIPTDIR=%CD%
popd

for /R %%f in (*.asm) do echo %%~nxf & python "%SCRIPTDIR%\ScenarioCompile.py" -f "%SCRIPTDIR%\Gao4-Font_NoEmoji.txt" "%%f" "%%~dpnf.lsp"
