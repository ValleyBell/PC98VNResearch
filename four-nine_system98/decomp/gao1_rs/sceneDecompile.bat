@echo off
set BASEPATH=%~dp0
pushd %BASEPATH%..\..
set SCRIPTDIR=%CD%
popd

for /R %%f in (*.lsp) do echo %%~nxf & python "%SCRIPTDIR%\ScenarioDecompile.py" -e -f "%SCRIPTDIR%\Gao4-Font_NoEmoji.txt" "%%f" "%%~dpnf.asm"
