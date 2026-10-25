rem @echo off
set BASEPATH=%~dp0
pushd %BASEPATH%..\..
set SCRIPTDIR=%CD%
popd

cd "MAY-PC98"
IF NOT EXIST unpack (
for %%f in (*.CAT) do python "%SCRIPTDIR%\sys98_packer.py" -x "%%f" "unpack/%%~nf"
)

rem generate symbols file
for %%f in (unpack\DISK_A\may_sub.s) do @echo %%~nxf & python "%SCRIPTDIR%\ScenarioDecompile.py" -V 3.12 -e -f "%SCRIPTDIR%\Gao4-Font_NoEmoji.txt" -b 0x4000 -s "%%~dpnf.sym" "%%f" "%%~dpnf.asm"
@move /Y "unpack\DISK_A\may_sub.asm" "unpack\DISK_A\may_sub.asX"

rem decompile main files
for /R %%f in (*.s) do @echo %%~nxf & python "%SCRIPTDIR%\ScenarioDecompile.py" -V 3.12 -e -f "%SCRIPTDIR%\Gao4-Font_NoEmoji.txt" -i "unpack\DISK_A\may_sub.sym" "%%f" "%%~dpnf.asm"

rem replace overwritten "sub" module with correct file
@move /Y "unpack\DISK_A\may_sub.asX" "unpack\DISK_A\may_sub.asm"
pause
