rem @echo off
set BASEPATH=%~dp0
pushd %BASEPATH%..\..
set SCRIPTDIR=%CD%
popd

cd "MAYE-WIN"
IF NOT EXIST unpack (
  python "%SCRIPTDIR%\mayclub_packer.py" -x "MAY0.LST" "unpack"
)

rem generate symbols file
for %%f in (unpack\MAY_SUB.S) do @echo %%~nxf & python "%SCRIPTDIR%\ScenarioDecompile.py" -V 4 -e -f "%SCRIPTDIR%\Gao4-Font_NoEmoji.txt" -b 0x4000 -s "%%~dpnf.sym" "%%f" "%%~dpnf.asm"
@move /Y "unpack\MAY_SUB.asm" "unpack\MAY_SUB.asX"

rem decompile main files
for /R %%f in (*.s) do @echo %%~nxf & python "%SCRIPTDIR%\ScenarioDecompile.py" -V 4 -e -f "%SCRIPTDIR%\Gao4-Font_NoEmoji.txt" -i "unpack\may_sub.sym" "%%f" "%%~dpnf.asm"

rem replace overwritten "sub" module with correct file
@move /Y "unpack\MAY_SUB.asX" "unpack\MAY_SUB.asm"

rem for %%f in (unpack\MAY_SUB.S) do @echo %%~nxf & python "%SCRIPTDIR%\wmp2_dsd_decode.py" -d "%%f" "%%~dpnf.scn"
pause
