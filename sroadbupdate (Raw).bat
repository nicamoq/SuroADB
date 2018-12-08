@echo off
mode con: cols=58lines=15
CD %MYFILES%
cls
title SuroADB Update Checker
color 0f
set rawver=
set newver=
set filerawver=
set betabuild=
set betabuildno=
set ov=0
set bv=0
IF EXIST "%MYFILES%\sroadbverinfo.bat" CALL "%MYFILES%\sroadbverinfo.bat"
IF NOT EXIST "%MYFILES%\sroadbverinfo.bat" goto missingverinfo
set tempdir=%MYFILES%\sroadbtemp
set diode=f0
taskkill /F /IM download.exe
cls
IF EXIST "%MYFILES%\SuroADB\sroadbcol.bat" call "%MYFILES%\SuroADB\sroadbcol.bat"
color %diode%
echo %TIME% %DATE% SuroADB Update Check service for %filerawver% started >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
IF NOT EXIST "%MYFILES%\sroadbtemp" MKDIR "%MYFILES%\sroadbtemp"
IF NOT EXIST "%MYFILES%\sroadbtemp\SuroADB" MKDIR "%MYFILES%\sroadbtemp\SuroADB"
IF NOT EXIST "%MYFILES%\sroadbtemp\Update" MKDIR "%MYFILES%\sroadbtemp\Update"
IF NOT EXIST "%MYFILES%\sroadbtemp\Update" MKDIR "%MYFILES%\sroadbtemp\db"
IF NOT EXIST "%MYFILES%\sroadbtemp\Apk" MKDIR "%MYFILES%\sroadbtemp\Apk"
IF NOT %rawver%==%filerawver% goto av
IF NOT EXIST "%MYFILES%\download.exe" goto missingfiles
DEL /Q "%MYFILES%\updatechk.bat"
DEL /Q "%MYFILES%\sroadbdb.bat"
cls
echo Fetching updatechk.bat (contains new version information) (GitHub)
echo.
download https://github.com/nicamoq/SuroADB/raw/master/updatechk.bat updatechk.bat
echo.
echo Fetching sroadbdb.bat (contains latest databases for comparison) (GitHub)
echo.
download https://github.com/nicamoq/SuroADB/raw/master/sroadbdb.bat sroadbdb.bat
echo.
IF EXIST "%MYFILES%\sroadbdb.bat" echo %TIME% downloaded the latest database >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
IF EXIST "%MYFILES%\sroadbdb.bat" echo Latest sroadbdb.bat databases has been downloaded!
MOVE /Y "%MYFILES%\sroadbdb.bat" "%MYFILES%\sroadbtemp\db" >nul
MOVE /Y "%MYFILES%\updatechk.bat" "%MYFILES%\sroadbtemp\Update" >nul
ping localhost -n 3 >nul
IF NOT EXIST "%MYFILES%\sroadbbetaui.bat" goto missingfiles
goto cont

:cont
IF EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" call "%MYFILES%\sroadbtemp\Update\updatechk.bat"
IF NOT EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" goto not
IF %ov%==1 goto updtno
IF NOT %rawver%==%filerawver% goto av
IF NOT %betabuild%==%betabuildno% goto bv
IF %rawver%==%filerawver% goto updtno
cls
echo Variable error! >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
echo Variable error! There must be a mistake in the server. Please retry in a few minutes.
ping localhost -n 3 >nul
cls
exit

:av
taskkill /F /IM download.exe
cls
echo SuroADB %newver% is available! starting sroadbupdateui.bat
echo %TIME% update found: new rawver %rawver% >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
start "%SystemRoot%\cmd.exe" "%MYFILES%\sroadbupdateui.bat"
exit

:bv
IF %bv%==1 exit
taskkill /F /IM download.exe
set newbuild=%betabuild%
IF EXIST "%tempdir%\SuroADB\betabuild.bat" CALL "%tempdir%\SuroADB\betabuild.bat"
IF %newbuild%==%betabuild% exit
IF NOT EXIST "%MYFILES%\sroadbbetaui.bat" goto missingfiles
start "%SystemRoot%\cmd.exe" "%MYFILES%\sroadbbetaui.bat"
exit

:updtno
taskkill /F /IM download.exe
IF NOT %betabuild%==%betabuildno% goto bv
cls
echo No updates found! Currently using the latest version.
ping localhost -n 2 >nul
echo %TIME% no updates found for rawver:%filerawver% >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
IF EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" DEL /Q "%MYFILES%\sroadbtemp\Update\updatechk.bat"
exit

:not
taskkill /F /IM download.exe
cls
echo File/path error! updatechk.bat has not been found, probably due to download failure or path error
ping localhost -n 2 >nul
echo %TIME% file error or file access error : must be error downloading, or wrong path >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
IF EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" DEL /Q "%MYFILES%\sroadbtemp\Update\updatechk.bat"
exit

:missingfiles
taskkill /F /IM download.exe
cls
echo Missing file! download.exe is missing. Please exit then relaunch SuroADB.
ping localhost -n 3 >nul
echo %TIME% download.exe missing >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
IF EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" DEL /Q "%MYFILES%\sroadbtemp\Update\updatechk.bat"
ping localhost -n 3 >nul
cls
exit

:missingverinfo
taskkill /F /IM download.exe
cls
echo sroadbverinfo.bat is missing. Please exit then relaunch SuroADB.
echo %TIME% sroadbverinfo.bat missing >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
ping localhost -n 3 >nul
cls
exit