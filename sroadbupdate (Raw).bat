@echo off
CD %MYFILES%
cls
title SuroADB Update Checker
color f0
set rawver=121
set newver=12.1
set filerawver=121
set betabuild=121E
set betabuildno=121E
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
IF EXIST "%MYFILES%\sroadbdb.bat" echo %TIME% downloaded the latest database >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
IF EXIST "%MYFILES%\sroadbdb.bat" echo Latest sroadbdb.bat databases has been downloaded!
echo.
MOVE /Y "%MYFILES%\sroadbdb.bat" "%MYFILES%\sroadbtemp\db" >nul
MOVE /Y "%MYFILES%\updatechk.bat" "%MYFILES%\sroadbtemp\Update" >nul
ping localhost -n 3 >nul
IF EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" call "%MYFILES%\sroadbtemp\Update\updatechk.bat"
IF NOT EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" goto not
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
taskkill /F /IM download.exe
rem ShowSelf
echo %TIME% SuroADB BETA %betabuild% available! >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
cls
echo SuroADB BETA %betabuild% is available!
echo.
echo The BETA release you are using is %betabuildno%
echo.
echo Would you like to download and directly use %betabuild%?
echo.
set /p bvv= Y / N : 
cls
IF /i %bvv%==Y goto bv2
IF /i %bvv%==N exit
goto bv

:bv2
echo %TIME% downloading SuroADB BETA %betabuild% >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
title Downloading SuroADB BETA %betabuild% (400kb)
cls
echo Downloading SuroADB %betabuild%..
download https://github.com/nicamoq/SuroADB/raw/master/SuroADB!Beta.exe SuroADB!Beta.exe
IF NOT EXIST "%MYFILES%\SuroADB!Beta.exe" goto bv404
IF EXIST "%MYFILES%\SuroADB!Beta.exe" goto bv3
:bv404
echo %TIME% fail to download, retrying.. >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
title Download failed
cls
echo Retrying in 3 seconds..
ping localhost -n 4 >nul
goto bv2

:bv3
title Setting up...
cls
IF NOT EXIST "%MYFILES%\adb.exe" goto v2f
IF NOT EXIST "%MYFILES%\AdbWinApi.dll" goto v2f
IF NOT EXIST "%MYFILES%\AdbWinUsbApi.dll" goto v2f
IF NOT EXIST "%MYFILES%\dmtracedump.exe" goto v2f
IF NOT EXIST "%MYFILES%\etc1tool.exe" goto v2f
IF NOT EXIST "%MYFILES%\fastboot.exe" goto v2f
IF NOT EXIST "%MYFILES%\hprof-conv.exe" goto v2f
IF NOT EXIST "%MYFILES%\make_f2fs.exe" goto v2f
IF NOT EXIST "%MYFILES%\mke2fs.conf" goto v2f
IF NOT EXIST "%MYFILES%\mke2fs.exe" goto v2f
IF NOT EXIST "%MYFILES%\source.properties" goto v2f
IF NOT EXIST "%MYFILES%\sqlite3.exe" goto v2f
echo set betabuild=%betabuild% > "%tempdir%\SuroADB\betabuild.bat"
cls
:bv4
cls
echo SuroADB Beta %betabuild% is now available to use.
echo.
echo It will automatically start after you launch the previous
echo version of SuroADB (%betabuildno%)
echo.
pause
exit



:v2f
echo %TIME% missing files for betabuild config >> "%MYFILES%\sroadbtemp\Update\updatelog.txt"
cls
echo Some files are missing! please start the 6 MB SuroADB package again
echo to extract required files.
pause
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