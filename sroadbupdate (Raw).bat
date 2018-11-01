CD %MYFILES%
cls
title SuroADB Update Checker
color f0
set rawver=121
set newver=12.1
set filerawver=121
set diode=f0
taskkill /F /IM download.exe
cls
IF EXIST "%MYFILES%\SuroADB\sroadbcol.bat" call "%MYFILES%\SuroADB\sroadbcol.bat"
color %diode%
echo %TIME% %DATE% SuroADB Update Check service for %filerawver% started >> %MYFILES%\sroadbtemp\Update\updatelog.txt
IF NOT EXIST "%MYFILES%\sroadbtemp" MKDIR "%MYFILES%\sroadbtemp"
IF NOT EXIST "%MYFILES%\sroadbtemp\Update" MKDIR "%MYFILES%\sroadbtemp\Update"
IF NOT EXIST "%MYFILES%\sroadbtemp\Update" MKDIR "%MYFILES%\sroadbtemp\db"
IF NOT EXIST "%MYFILES%\sroadbtemp\Apk" MKDIR "%MYFILES%\sroadbtemp\Apk"
IF EXIST "%MYFILES%\SuroADB\Update\updatechk.bat" call "%MYFILES%\Update\updatechk.bat"
IF NOT %rawver%==%filerawver% goto av
IF EXIST "%MYFILES%\Update\sroadbtemp\updatechk.bat" DEL /Q "%MYFILES%\sroadbtemp\Update\updatechk.bat"
IF NOT EXIST "%MYFILES%\download.exe" goto missingfiles
DEL /Q %MYFILES%\updatechk.bat
DEL /Q %MYFILES%\sroadbdb.bat
cls
echo Fetching updatechk.bat (contains new version information) (pastebin.com/raw/R5TTPUzW)
echo.
download https://github.com/nicamoq/SuroADB/raw/master/updatechk.bat updatechk.bat
echo.
echo Fetching sroadbdb.bat (contains latest databases for comparison) (pastebin.com/raw/2Udw93tz)
echo.
download https://github.com/nicamoq/SuroADB/raw/master/sroadbdb.bat sroadbdb.bat
IF EXIST "%MYFILES%\sroadbdb.bat" echo %TIME% downloaded the latest database >> %MYFILES%\sroadbtemp\Update\updatelog.txt
IF EXIST "%MYFILES%\sroadbdb.bat" echo Latest sroadbdb.bat databases has been downloaded!
echo.
MOVE /Y "%MYFILES%\sroadbdb.bat" "%MYFILES%\sroadbtemp\db" >nul
MOVE /Y "%MYFILES%\updatechk.bat" "%MYFILES%\sroadbtemp\Update" >nul
ping localhost -n 3 >nul
IF EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" call "%MYFILES%\sroadbtemp\Update\updatechk.bat"
IF NOT EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" goto not
IF NOT %rawver%==%filerawver% goto av
IF %rawver%==%filerawver% goto updtno
cls
echo Variable error! >> %MYFILES%\sroadbtemp\Update\updatelog.txt
echo Variable error! There must be a mistake in the server. Please retry in a few minutes.
ping localhost -n 3 >nul
cls
exit

:av
taskkill /F /IM download.exe
cls
echo SuroADB %newver% is available! starting sroadbupdateui.bat
echo %TIME% update found: new rawver %rawver% >> %MYFILES%\sroadbtemp\Update\updatelog.txt
start "%SystemRoot%\cmd.exe" "%MYFILES%\sroadbupdateui.bat"
exit

:updtno
taskkill /F /IM download.exe
cls
echo No updates found! Currently using the latest version.
ping localhost -n 2 >nul
echo %TIME% no updates found for rawver:%filerawver% >> %MYFILES%\sroadbtemp\Update\updatelog.txt
IF EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" DEL /Q "%MYFILES%\sroadbtemp\Update\updatechk.bat"
exit

:not
taskkill /F /IM download.exe
cls
echo File/path error! updatechk.bat has not been found, probably due to download failure or path error
ping localhost -n 2 >nul
echo %TIME% file error or file access error : must be error downloading, or wrong path >> %MYFILES%\sroadbtemp\Update\updatelog.txt
IF EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" DEL /Q "%MYFILES%\sroadbtemp\Update\updatechk.bat"
exit

:missingfiles
taskkill /F /IM download.exe
cls
echo Missing file! download.exe is missing. Please exit then relaunch SuroADB.
ping localhost -n 3 >nul
echo %TIME% download.exe missing >> %MYFILES%\sroadbtemp\Update\updatelog.txt
IF EXIST "%MYFILES%\sroadbtemp\Update\updatechk.bat" DEL /Q "%MYFILES%\sroadbtemp\Update\updatechk.bat"
ping localhost -n 3 >nul
cls
exit
