@echo off
:verydeeprestart
set version=13
set newver=%version%
set rawver=13
set betabuild=13B
set betabuildno=13B
set filerawver=13
set diode=f0
set logst=YES
set entries=0
:stcounter
set trost=0
:wifimodevariables
set deviceip=NOT_SET
set sessionid=%random%
set sdconfig=/sdcard
set exsdconfig=/storage/sdcard0
:pathvariables
set wdre=%MYFILES%
set audir=%MYFILES%\SuroADB
set tempdir=%MYFILES%\sroadbtemp
set instal=%tempdir%\Apk
set pullf=NOT_SET
set pushf=NOT_SET
set scrsp=NOT_SET
set scrp=NOT_SET
REM CenterSelf
title SuroADB %version% : Verifying directories.. 
CD %MYFILES%
IF NOT "%cd%"=="%MYFILES%" goto cderror2
IF NOT EXIST "%audir%" MKDIR "%audir%"
IF NOT EXIST "%tempdir%" MKDIR "%tempdir%"
IF NOT EXIST "%tempdir%\SuroADB" MKDIR "%tempdir%\SuroADB"
IF NOT EXIST "%tempdir%\db" MKDIR "%tempdir%\db"
IF NOT EXIST "%tempdir%\Apk" MKDIR "%tempdir%\Apk"
IF EXIST "%tempdir%\srodb\sroadbdb.bat" call "%tempdir%\srodb\sroadbdb.bat"
cls

:: This will create the version info file for update checking
(
echo set version=%version%
echo set newver=%version%
echo set rawver=%rawver%
echo set betabuild=%betabuild%
echo set betabuildno=%betabuildno%
echo set filerawver=%filerawver%
echo exit /b
) > "%MYFILES%\sroadbverinfo.bat"

:: This will start SuroADB!Beta.exe, if available
IF EXIST "%tempdir%\SuroADB\betabuild.bat" call "%tempdir%\SuroADB\betabuild.bat"
IF NOT %betabuild%==%betabuildno% goto betabuildstarter
goto srocounter
:betabuildstarter
echo %TIME% %DATE% SuroADB!Beta %betabuild% is available! >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF NOT EXIST "%MYFILES%\SuroADB!Beta.exe" echo %TIME% %DATE% SuroADB!Beta.exe is missing.. >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF NOT EXIST "%MYFILES%\SuroADB!Beta.exe" goto betabuildstarter2
echo %TIME% %DATE% Starting SuroADB!Beta.exe.. >> "%tempdir%\SuroADB\sroadb-runtime.txt"
start /B SuroADB!Beta.exe
exit
:betabuildstarter2
set rest=betabuildstarter
goto restore



:: This will count how many times SuroADB has started
:srocounter
IF NOT EXIST "%tempdir%\SuroADB\sroadb-counter.bat" goto countercr
IF EXIST "%tempdir%\SuroADB\sroadb-counter.bat" CALL "%tempdir%\SuroADB\sroadb-counter.bat"
set /A trost=%trost% + 1
(
echo set trost=%trost%
echo exit /b
) > "%tempdir%\SuroADB\sroadb-counter.bat"
IF %trost%==5 goto srocounter2
goto runtimelog
:countercr
(
echo set trost=1
echo exit /b
) > "%tempdir%\SuroADB\sroadb-counter.bat"
goto runtimelog


:srocounter2
IF EXIST "%audir%\sroadbcol.bat" call "%audir%\sroadbcol.bat"
IF EXIST "%audir%\sroadbcol.bat" color %diode%
IF %ERRORLEVEL%==1 set rest=cols
IF %ERRORLEVEL%==1 goto restore
title SuroADB %version% : Hello
cls
echo Hello! Thank you for using SuroADB!
echo.
echo I would really appreciate any kind of message regarding
echo SuroADB, for example, an angry one regarding the slow
echo updates! :D
echo.
echo You can input a fake email.. I don't mind! You can leave
echo an anonymous message on my website's contact page.
echo.
echo I won't bother you anymore after this. I promise!
echo.
set /p sroc2= Please!? Y / N : 
cls
IF /i %sroc2%==Y start https://suroadb.jimdofree.com/contact/
IF /i %sroc2%==Y goto runtimelog
IF /i %sroc2%==N goto runtimelog
goto srocounter2

:deeprestart
:launch
:: This will log events on runtime
:runtimelog
title SuroADB %version% : Logging runtime events..
IF NOT EXIST "%tempdir%\SuroADB\sroadb-runtime.txt" echo SuroADB %version% Runtime Logs > "%tempdir%\SuroADB\sroadb-runtime.txt"
echo %TIME% %DATE% suroadb %version% started >> "%tempdir%\SuroADB\sroadb-runtime.txt"

:: This will set your selected color scheme.
:colorset
title SuroADB %version% : Setting color scheme.. 
IF EXIST "%audir%\sroadbcol.bat" call "%audir%\sroadbcol.bat"
IF EXIST "%audir%\sroadbcol.bat" color %diode%
echo %TIME% %DATE% color scheme changed to %diode% >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF %ERRORLEVEL%==1 set rest=cols
IF %ERRORLEVEL%==1 goto restore
goto cfgcall


:: This calls the config (path file)
:cfgcall
title SuroADB %version% : Calling config files.. 
IF EXIST "%audir%\sroadbsdconfig.bat" call "%audir%\sroadbsdconfig.bat"
IF EXIST "%audir%\sroadbexsdconfig.bat" call "%audir%\sroadbsdconfig.bat"
IF EXIST "%audir%\sroadbsdconfig.bat" echo %TIME% %DATE% sdconfig called >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF EXIST "%audir%\sroadbexsdconfig.bat" echo %TIME% %DATE% exsdconfig called >> "%tempdir%\SuroADB\sroadb-runtime.txt"

:: This will check for updates at start.
:updtchk
IF NOT EXIST "%audir%" MKDIR "%audir%"
IF EXIST "%MYFILES%\updtstop.txt" echo %TIME% %DATE% updtstop.txt present >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF EXIST "%MYFILES%\updtstop.txt" goto wifidebugmode

:: New Update Check system, now background threadded and relies on sroadbupdate.exe
:updatelaunchsilent
title SuroADB %version% : Preparing for update check.. 
cls
IF EXIST "%MYFILES%\updatechk.bat" DEL /Q "%MYFILES%\updatechk.bat"
IF NOT EXIST "%MYFILES%\sroadbupdate.exe" goto v2f
echo %TIME% %DATE% SuroADB update check service started >> "%tempdir%\SuroADB\sroadb-runtime.txt"
title SuroADB %version% : Starting sroadbupdate.exe.. 
rem LaunchSilent sroadbupdate.exe
goto wifidebugmode

:: This starts the ADB wifi debugging mode (WiFi mode)
:wifidebugmode
cls
IF EXIST "%audir%\deviceip.bat" call "%audir%\deviceip.bat"
IF EXIST "%audir%\deviceip.bat" echo %TIME% %DATE% deviceip.bat present >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF %deviceip%==NOT_SET goto deldevip
goto wifidebugmode0
:deldevip
IF EXIST "%audir%\deviceip.bat" DEL /Q "%audir%\deviceip.bat"
:wifidebugmode0
IF EXIST "%audir%\deviceip.bat" goto wifidebugmode2
goto credb
:wifidebugmode2
title SuroADB %version% : Configuring wifi debug mode.. 
cls
set wdbm1=cont
adb devices
adb tcpip 5555
echo Currently starting Wifi debug mode, please disconnect
echo your device from your computer, if you see it in the list
echo before continuing.
echo.
echo Press ENTER after disconnecting device.
echo If you see a "no device" error, please connect your device.
pause>nul
adb tcpip 5555
cls
echo Connecting to %deviceip%:5555
ping localhost -n 3 >nul
adb connect %deviceip%:5555
:wifidebugmode3
 cls
 adb devices
 echo Do you see "%deviceip%:5555" above?
 echo.
 set /p wdbm1= Y / N : 
 cls
 IF /i %wdbm1%==Y goto credb
 IF /i %wdbm1%==N goto wifidebugdel
 goto wifidebugmode3
 
 :wifidebugdel
 IF EXIST "%audir%\deviceip.bat" DEL /Q "%audir%\deviceip.bat"
 cls
 echo Wifi debug mode will not apply at start anymore.
 echo.
 echo Please perform the setup again in the menu.
 echo.
 pause
 goto credb
 


:: This creates a client-sided comparison database
:credb
title SuroADB %version% : Configuring database.. 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" goto stt
(
echo @echo off
echo echo ERROR: Comparison database is not downloaded yet!
echo echo please enable SuroADB update fetching, or manually
echo echo download databases in settings - update
ping localhost -n 2 >nul
echo exit /b 
) > "%tempdir%\db\sroadbdb.bat"
goto stt

:: These creates the necessary log files.
:stt
title SuroADB %version% : Starting daemon.. 
cls
echo %TIME% %DATE% runtime adb devices check started >> "%tempdir%\SuroADB\sroadb-runtime.txt"
adb devices
cls
:: This checks the presence of SDCONFIG
:sdconfig
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" goto sdconfigver
goto stt1
:sdconfigver
IF NOT EXIST "%audir%\sroadbsdconfig.bat" goto cfgcrr
IF NOT EXIST "%audir%\sroadbexsdconfig.bat" goto cfgcrr
goto stt1
:cfgcrr
title SuroADB %version% : Configuring database.. 
cls
echo Before you can start using SuroADB, please configure
echo the device paths.
echo.
echo Enter the path to your INTERNAL storage. (ex. /sdcard)
echo.
echo Please do not close it with a slash ( / ) at the end.
echo.
set /p sdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set sdconfig=%sdconfig% > "%audir%\sroadbsdconfig.bat"
goto cfgcrr2
:cfgcrr2
cls
echo Internal: %sdconfig%
echo.
echo Enter the path to your EXTERNAL storage. (ex. /storage/sdcard0)
echo.
echo Please do not enclose it with a slash ( / ) at the end.
echo.
set /p exsdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set exsdconfig=%exsdconfig% > "%audir%\sroadbexsdconfig.bat"
goto cfgcrr3

:cfgcrr3
cls
echo Internal: %sdconfig% External: %exsdconfig%
echo.
echo Is this correct?
echo.
echo IN - Change the internal path
echo EX - Change the external path
echo OK - They're correct
echo.
echo.
set /p cfgcre= IN / EX / OK : 
cls
IF /i %cfgcre%==IN goto incfgc
IF /i %cfgcre%==EX goto excfgc
IF /i %cfgcre%==OK goto clsmenu
goto cfgcrr3

:incfgc
cls
echo Current IN: %sdconfig% Current EX: %exsdconfig%
echo.
echo Enter the path to the INTERNAL storage
echo.
echo.
set /p sdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set sdconfig=%sdconfig% > "%audir%\sroadbsdconfig.bat"
goto cfgcrr3

:excfgc
cls
echo Current EX: %exsdconfig% Current IN: %sdconfig%
echo.
echo Enter the path to the EXTERNAL storage
echo.
echo.
set /p exsdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set exsdconfig=%exsdconfig% > "%audir%\sroadbexsdconfig.bat"
goto cfgcrr3



:stt1
title SuroADB %version% : Configuring directories.. 
IF NOT EXIST "%audir%" MKDIR "%audir%"
IF NOT EXIST "%tempdir%" MKDIR "%tempdir%"
IF NOT EXIST "%tempdir%\SuroADB" MKDIR "%tempdir%\SuroADB"
IF NOT EXIST "%tempdir%\Push" MKDIR "%tempdir%\Push"
IF NOT EXIST "%tempdir%\Update" MKDIR "%tempdir%\Update"
IF NOT EXIST "%tempdir%\db" MKDIR "%tempdir%\db"
IF NOT EXIST "%audir%" MKDIR "%audir%"
title SuroADB %version% : Configuring log files.. 
IF EXIST "%audir%\sroadb-logs.txt" goto elog
goto logmk
:elog
IF EXIST "%audir%\sroadb-errorlog.txt" goto stt2
goto logmk
:logmk
echo %TIME% %DATE% log files created >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF NOT EXIST "%audir%\sroadb-errorlog.txt" echo SuroADB %version% Error Logging > "%audir%\sroadb-errorlog.txt"
IF NOT EXIST "%audir%\sroadb-logs.txt" goto srodblmk
goto sttt
:srodblmk
cls
ping localhost -n 2 >nul
(
echo SuroADB %version% Logs
echo Current Temp Folder : %wdre%
echo.
echo %TIME% %DATE% Log files generated.
) > "%audir%\sroadb-logs.txt"
goto stt2

:: This will be added to the log file in each start.
:sttt
:stt2

(
echo =============================================
echo.
echo SuroADB : %version% %betabuild% started %TIME% %DATE%
adb devices
IF EXIST "%audir%\deviceip.bat" echo %TIME% %DATE% ADB connected to %wirelesip%:5555
echo.
) >> "%audir%\sroadb-logs.txt"


color %diode%
IF %ERRORLEVEL%==1 set rest=cols
IF %ERRORLEVEL%==1 goto restore
title SuroADB %version%
color %diode%
cls


:: This will detect if an older version of SuroADB is present.
IF EXIST "%MYFILES%\sroadb71w.txt" set localver=7.1
IF EXIST "%MYFILES%\sroadb71w.txt" goto oldver
IF EXIST "%MYFILES%\sroadb80w.txt" set localver=8.0
IF EXIST "%MYFILES%\sroadb80w.txt" goto oldver
IF EXIST "%MYFILES%\sroadb81w.txt" set localver=8.1
IF EXIST "%MYFILES%\sroadb81w.txt" goto oldver
IF EXIST "%MYFILES%\sroadb90w.txt" set localver=9.0
IF EXIST "%MYFILES%\sroadb90w.txt" goto oldver
IF EXIST "%MYFILES%\sroadb91w.txt" set localver=9.1
IF EXIST "%MYFILES%\sroadb91w.txt" goto oldver
IF EXIST "%MYFILES%\sroadb10w.txt" set localver=10
IF EXIST "%MYFILES%\sroadb10w.txt" goto oldver
IF EXIST "%MYFILES%\sroadb101w.txt" set localver=10.1
IF EXIST "%MYFILES%\sroadb101w.txt" goto oldver
IF EXIST "%MYFILES%\sroadb11w.txt" set localver=11
IF EXIST "%MYFILES%\sroadb11w.txt" goto oldvergen
IF EXIST "%MYFILES%\sroadb111w.txt" set localver=11.1
IF EXIST "%MYFILES%\sroadb111w.txt" goto oldvergen
IF EXIST "%MYFILES%\sroadb12w.txt" set localver=12
IF EXIST "%MYFILES%\sroadb12w.txt" goto oldvergen
IF EXIST "%MYFILES%\sroadb121w.txt" set localver=12.1
IF EXIST "%MYFILES%\sroadb121w.txt" goto oldvergen


goto conft


:: Revised oldver message, will change how it displays on newer (10th) gen versions in the future
:oldver
DEL /Q "%MYFILES%\sroadb71w.txt"
DEL /Q "%MYFILES%\sroadb80w.txt"
DEL /Q "%MYFILES%\sroadb81w.txt"
DEL /Q "%MYFILES%\sroadb90w.txt"
DEL /Q "%MYFILES%\sroadb91w.txt"
DEL /Q "%MYFILES%\sroadb10w.txt"
DEL /Q "%MYFILES%\sroadb101w.txt"
cls
:oldver2
title SuroADB %version%
cls
echo I see you have used SuroADB %localver% before!
echo.
echo A lot has changed since then, why don't
echo you try these new features?
echo.
echo - ADB WiFi mode
echo - Compact UI mode
echo - Path configs
echo - And some other stuff I forgot I added!
echo.
echo There's also a LOT of performance improvements and
echo bug fixes!
echo.
echo.
pause
goto conft

:oldvergen
DEL /Q "%MYFILES%\sroadb11w.txt"
DEL /Q "%MYFILES%\sroadb111w.txt"
DEL /Q "%MYFILES%\sroadb12w.txt"
DEL /Q "%MYFILES%\sroadb121w.txt"
title SuroADB %version%
cls
echo You've been using SuroADB %localver%. Great!
echo.
echo I would really appreciate any kind of message regarding
echo SuroADB, for example, an angry one regarding the slow
echo updates! :D
echo.
echo You can input a fake email.. I don't mind! You can leave
echo an anonymous message on my website's contact page.
echo.
echo I won't bother you anymore after this. I promise!
echo.
set /p sroc2= Please!? Y / N : 
cls
IF /i %sroc2%==Y start https://suroadb.jimdofree.com/contact/
IF /i %sroc2%==Y goto conft
IF /i %sroc2%==N goto conft
goto oldvergen

:conft
title SuroADB %version% : Configuring logs.. 
cls
:: This will enable (or disable) logging. Depends on your settings.
IF EXIST "%audir%\sroadblogs.bat" echo %TIME% %DATE% sroadblogs.bat present >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF EXIST "%audir%\sroadblogs.bat" call "%audir%\sroadblogs.bat"

:: This automates the cd to the one you set.
:: MYFILES is the temp folder for suroadb.
:precd
title SuroADB %version% : Configuring directories.. 
cd "%MYFILES%"
IF NOT EXIST "%audir%\sroadbcd.bat" cd "%wdre%"
IF NOT "%cd%"=="%MYFILES%" goto cderror2
IF NOT EXIST "%audir%\sroadbcd.bat" goto preload
IF EXIST "%audir%\sroadbcd.bat" goto cdver2
:cdver2
IF EXIST "%audir%\sroadbcd.bat" call "%audir%\sroadbcd.bat"
IF "%sroadbcd%"=="" set sroadbcd=%wdre%
cd "%sroadbcd%"
IF NOT EXIST "%sroadbcd%" goto cderror
IF NOT "%cd%"=="%sroadbcd%" goto cderror2
set rest=customcd
IF %ERRORLEVEL%==1 goto restore
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" goto menu
IF "%cd%"=="%sroadbcd%" goto menu
goto restore

:: In case of a batch-side error, this will appear.
:: Errors usually happen when certain automatic-restore scripts (ex. sroadbcd sets a custom wd)
:: have wrong commands in them.
:restore
IF %rest%==cols DEL /Q "%audir%\sroadbcol.bat"
IF %rest%==cols echo %TIME% color value "%diode%" has set ERRORLEVEL to 1. >> "%audir%\sroadb-errorlog.txt"
IF %rest%==cols set diode=f0
IF %rest%==cols goto interfacemenu
IF %rest%==betabuildstarter echo %TIME% betabuild.bat was changed, but SuroADB!Beta.exe is missing. Restoring file.. > "%audir%\sroadb-errorlog.txt"
IF %rest%==betabuildstarter (
echo set betabuild=%betabuildno%
echo exit /b
) > "%tempdir%\SuroADB\betabuild.bat"
IF %rest%==betabuildstarter echo %TIME% betabuild.bat restored to %betabuildno% compatibility. > "%audir%\sroadb-errorlog.txt"
IF %rest%==betabuildstarter goto verydeeprestart
IF %rest%==customcd del /Q "%audir%\sroadbcd.bat"
IF %rest%==customcd echo %TIME% invalid path "%sroadbcd%". >> "%audir%\sroadb-errorlog.txt"
IF %rest%==customcd goto verydeeprestart

:restore1
title SuroADB %version% : FATAL ERROR OCCURED
cls
echo An error has occured that prevented SuroADB from doing something. 
echo.
echo In an attempt to fix it, SuroADB will delete automatic restore scripts in
echo.
echo %audir%
echo.
echo This will affect set custom directories, custom window color, and others.
echo.
echo For more information, you may find something useful in:
echo %audir%\sroadb-errorlog.txt
echo.
pause
cls
DEL /Q "%audir%\sroadb%filerawver%w.txt"
DEL /Q "%audir%\sroadbcd.bat"
DEL /Q "%audir%\sroadbcol.bat"
DEL /Q "%audir%\sroadblogs.bat"
DEL /Q "%audir%\sdconfig.bat"
DEL /Q "%audir%\exsdconfig.bat"
DEL /Q "%audir%\deviceip.bat"
cls
exit

:cderror
title SuroADB %version% : Directory error.. 
cls
echo The custom working directory does not exist!
echo.
echo Would you like to set it again?
echo.
set /p cdrr= Y / N : 
cls
IF /i %cdrr%==Y goto repath2
IF /i %cdrr%==N goto defcd
goto cderror

:: This verifies if SuroADB still has a problem with configuring the default Working Directory.
:: When the auto-restore file is deleted yet it still fails to configure, SuroADB will
:: display cderror21
:cderror2
echo %TIME% Error while configuring working directory to %sroadbcd%. deleting sroadbcd.bat. >> "%audir%\sroadb-errorlog.txt"
DEL /Q %audir%\sroadbcd.bat
IF NOT EXIST "%audir%\sroadbcd.bat" echo %TIME% sroadbcd.bat deleted. retrying configuration. >> "%audir%\sroadb-errorlog.txt"
cls
cd "%MYFILES%"
IF NOT "%cd%"=="%MYFILES%" echo %TIME% unable to configure CD to "%sroadbcd%". >> "%audir%\sroadb-errorlog.txt"
IF NOT "%cd%"=="%MYFILES%" goto cderror21
IF "%cd%"=="%MYFILES%" echo %TIME% working directory set to %MYFILES%. >> "%audir%\sroadb-errorlog.txt"
goto stt
:cderror21
echo %TIME% unable to set cd to %MYFILES% >> "%audir%\sroadb-errorlog.txt"
set cderrorm=exit
REM CursorHide
title SuroADB %version% : Directory error.. 
cls
echo There was a problem with configuring the default working directory.
echo.
echo Please move and execute SuroADB in any location in the %HOMEDRIVE% drive.
echo.
echo.
echo Press ENTER to close
set /p cderrorm=
cls
IF %cderrorm%==exit exit
IF %cderrorm%==mattsuro goto adminmode
exit

:adminmode
title SuroADB %version% : Henlo matt
REM CursorShow
cls
:adminmode2
echo You have entered admin mode.
echo.
echo.
set /p adminm=
echo.
%adminm%
goto adminmode2



:defcd
IF NOT EXIST "%wdre%" echo %TIME% %wdre% does not exist! >> "%audir%\sroadb-errorlog.txt"
IF NOT EXIST "%wdre%" exit
cls
DEL /Q "%audir%\sroadbcd.bat"
cls
goto cdst

:cdst
cd "%MYFILES%"

:: This will run when sroadb00w.txt is not present.
:preload
IF EXIST "%tempdir%\SuroADB\betabuild.bat" call "%tempdir%\SuroADB\betabuild.bat"
IF %betabuild%==%betabuildno% goto preload2
IF NOT %betabuild%==%betabuildno% goto betabuildstarter
:preload2
(
echo set betabuild=%betabuildno%
echo exit /b
) > "%tempdir%\SuroADB\betabuild.bat"
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" goto menu
echo SuroADB %version% build %betabuildno% installed as %MYFILES% on %TIME% %DATE%  > "sroadb%filerawver%w.txt"
goto verify



:: This verifies that the extraction of embedded ADB files have been
:: successful. This only needs to run once.
:verify
title SuroADB %version% : Verifying files.. 
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
cls
goto wlcm2

:v2f
echo %TIME% Incomplete files >> "%audir%\sroadb-errorlog.txt"
title SuroADB %version% : File error.. 
cls
echo One or more files have not been extracted succesfully.
echo please start suroadb again.
echo.
pause
exit

:wlcm2
color %diode%
start "%SystemRoot%\notepad.exe" "%MYFILES%\readme-help.txt"
:wlcm211
title SuroADB %version% : Hello
cls
echo Thank you for downloading SuroADB!
echo.
echo You are using Version %version% build %betabuildno%.
echo.
echo Would you like a one minute setup?
echo.
set /p wlcm= Y / N : 
cls
IF /i %wlcm%==Y goto wlcnotice
IF /i %wlcm%==N goto wlcverify
goto wlcm211

:wlcverify
IF NOT EXIST "%audir%\sroadbexsdconfig.bat" goto wlcverify2
IF NOT EXIST "%audir%\sroadbsdconfig.bat" goto wlcverify2
goto clsmenu
:wlcverify2
color %diode%
cls
echo Before you can start using SuroADB, please configure
echo the device paths.
echo.
echo Enter the path to your INTERNAL storage. (ex. /sdcard)
echo.
echo Please do not close it with a slash ( / ) at the end.
echo.
set /p sdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set sdconfig=%sdconfig% > "%audir%\sroadbsdconfig.bat"
goto wlcver3
:wlcver3
cls
echo Internal: %sdconfig%
echo.
echo Enter the path to your EXTERNAL storage. (ex. /storage/sdcard0)
echo.
echo Please do not enclose it with a slash ( / ) at the end.
echo.
set /p exsdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set exsdconfig=%exsdconfig% > "%audir%\sroadbexsdconfig.bat"
goto wlcver4

:wlcver4
cls
echo Internal: %sdconfig% External: %exsdconfig%
echo.
echo Is this correct?
echo.
echo IN - Change the internal path
echo EX - Change the external path
echo OK - They're correct
echo.
echo.
set /p cfgcre= IN / EX / OK : 
cls
IF /i %cfgcre%==IN goto wlcin
IF /i %cfgcre%==EX goto wlcex
IF /i %cfgcre%==OK goto clsmenu
goto wlcver4

:wlcin
cls
echo Current IN: %sdconfig% Current EX: %exsdconfig%
echo.
echo Enter the path to the INTERNAL storage
echo.
echo.
set /p sdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set sdconfig=%sdconfig% > "%audir%\sroadbsdconfig.bat"
goto wlcver4

:wlcex
cls
echo Current EX: %exsdconfig% Current IN: %sdconfig%
echo.
echo Enter the path to the EXTERNAL storage
echo.
echo.
set /p exsdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set exsdconfig=%exsdconfig% > "%audir%\sroadbexsdconfig.bat"
goto wlcver4



:wlcnotice
IF EXIST "%audir%\sroadbsdconfig.bat" goto adminnotice
cls
echo Before you can start using SuroADB, please configure
echo the device paths.
echo.
echo Enter the path to your INTERNAL storage. (ex. /sdcard)
echo.
echo Please do not close it with a slash ( / ) at the end.
echo.
set /p sdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set sdconfig=%sdconfig% > "%audir%\sroadbsdconfig.bat"
goto wlcnotice1
:wlcnotice1
cls
echo Internal: %sdconfig%
echo.
echo Enter the path to your EXTERNAL storage. (ex. /storage/sdcard0)
echo.
echo Please do not enclose it with a slash ( / ) at the end.
echo.
set /p exsdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set exsdconfig=%exsdconfig% > "%audir%\sroadbexsdconfig.bat"
goto wlcnotice2

:wlcnotice2
cls
echo Internal: %sdconfig% External: %exsdconfig%
echo.
echo Is this correct?
echo.
echo IN - Change the internal path
echo EX - Change the external path
echo OK - They're correct
echo.
echo.
set /p cfgcre= IN / EX / OK : 
cls
IF /i %cfgcre%==IN goto wlcnoticein
IF /i %cfgcre%==EX goto wlcnoticeex
IF /i %cfgcre%==OK goto adminnotice
goto wlcnotice2

:wlcnoticein
cls
echo Current IN: %sdconfig% Current EX: %exsdconfig%
echo.
echo Enter the path to the INTERNAL storage
echo.
echo.
set /p sdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set sdconfig=%sdconfig% > "%audir%\sroadbsdconfig.bat"
goto wlcnotice2

:wlcnoticeex
cls
echo Current EX: %exsdconfig% Current IN: %sdconfig%
echo.
echo Enter the path to the EXTERNAL storage
echo.
echo.
set /p exsdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set exsdconfig=%exsdconfig% > "%audir%\sroadbexsdconfig.bat"
goto wlcnotice2


:adminnotice2
cls
echo Please make sure you're running on Administrator mode!
echo.
goto adminnotice3
:adminnotice
cls
:adminnotice3
set admw=N
title SuroADB %version%
echo SuroADB uses administrative permissions due to the way it
echo copies files in and out of the temp folder.
echo.
echo SuroADB still works without Administrative permissions,
echo although it may appear broken, and access denied errors
echo will show very often.
echo.
echo Please make sure you are using SuroADB as Administrator.
echo.
set /p admw= Y / N : 
cls
IF /i %admw%==Y goto wlcm21
IF /i %admw%==N goto adminnotice 2
goto adminnotice

:: This used to be the directory changer, removed on ver11
:wlcm21
set wlcmenu=A
IF EXIST "%audir%\sroadbuic.txt" goto wlcm3
cls
echo Choose a menu display scheme : 
echo.
echo A - Original interface with easy readabilty, requires further
echo      scrolling after executing some commands
echo.
echo B - Compact interface with minimal scrolling
echo.
set /p wlcmenu= A / B : 
cls
ping localhost -n 2 >nul
IF /i %wlcmenu%==A goto wlcm3
IF /i %wlcmenu%==B echo compact > "%audir%\sroadbuic.txt"
IF /i %wlcmenu%==B goto wlcm3
goto wlcm21

:wlcm3
set wlcm32=N
cls
IF %logst%==OFF goto updop
echo Logging is currently ON.
echo.
echo This allows logging for certain commands, like Push and Pull.
echo.
echo It can be useful for a lot of things, like keeping track of where
echo a file went, or knowing what preferences you were using.
echo.
echo Would you like to turn it off?
echo.
echo You can change this anytime in the settings menu.
echo.
set /p wlcm31= N / Y : 
cls
IF /i %wlcm31%==Y goto wlog
IF /i %wlcm31%==N goto updop
goto wlcm3
:wlog
ping localhost -n 2 >nul
cls
(
echo set logst=NO
echo exit /b
) > "%audir%\sroadblogs.bat"
IF EXIST "%audir%\sroadblogs.bat" call "%audir%\sroadblogs.bat"
goto updop

:updop
goto clsmenu

:opcancel
echo.
echo Operation cancelled.
echo Where: %opcode%
echo.
goto menu


:clsmenu
cls
:menu
:filever
IF NOT EXIST "%MYFILES%\adb.exe" goto v2f
IF NOT EXIST "%MYFILES%\AdbWinApi.dll" goto v2f
IF NOT EXIST "%MYFILES%\AdbWinUsbApi.dll" goto v2f
IF NOT EXIST "%MYFILES%\download.exe" goto v2f
IF NOT EXIST "%MYFILES%\fastboot.exe" goto v2f
color %diode%
set rest=color
IF %ERRORLEVEL%==1 goto restore
IF EXIST "%audir%\sroadbuic.txt" goto compactmenu
title SuroADB %version% build %betabuild%
echo What would you like to do?
echo.
echo      devices
echo      install
echo      uninstall
echo      packages
echo      pull
echo      push
echo      screenshot
echo      screenrecord
echo      poweroff
echo      reboot
echo.
echo      adb (custom mode)
echo      shell (adb shell mode)
echo      wifi (wireless adb mode)
echo.
echo      help
echo      settings (defaults, color scheme, update)
echo.
echo      restart
echo      exit
echo.
set /p main= : 
cls
IF /i %main%==adb goto sandbox1
IF /i %main%==shell goto shellmode
IF /i %main%==devices goto op1
IF /i %main%==install goto op2
IF /i %main%==uninstall goto op3
IF /i %main%==packages goto op4
IF /i %main%==pull goto op5
IF /i %main%==push goto op6
IF /i %main%==screenshot goto op51
IF /i %main%==screenrecord goto op52
IF /i %main%==poweroff goto op7
IF /i %main%==wifi goto wirels
IF /i %main%==reboot goto op8
IF /i %main%==help goto helpmenu
IF /i %main%==exit goto exitp
IF /i %main%==restart goto deeprestart
IF /i %main%==settings goto suroadbm
:errorm
cls
echo ERROR: The command does not exist or there's a mistype.
echo.
goto menu

:compactmenu
title SuroADB %version% build %betabuild%
echo What would you like to do?
echo.
echo      ADB:
echo      devices : install : uninstall : packages : pull : push
echo      screenshot : screenrecord : poweroff : reboot
echo      adb (custom mode) : shell (adb shell mode)
echo      wifi (wireless adb mode)
echo.
echo      SuroADB:
echo      help : settings : restart : exit
echo.
set /p main= : 
cls
IF /i %main%==adb goto sandbox1
IF /i %main%==shell goto shellmode
IF /i %main%==devices goto op1
IF /i %main%==install goto op2
IF /i %main%==uninstall goto op3
IF /i %main%==packages goto op4
IF /i %main%==pull goto op5
IF /i %main%==push goto op6
IF /i %main%==screenshot goto op51
IF /i %main%==screenrecord goto op52
IF /i %main%==poweroff goto op7
IF /i %main%==wifi goto wirels
IF /i %main%==reboot goto op8
IF /i %main%==help goto helpmenu
IF /i %main%==exit goto exitp
IF /i %main%==restart goto deeprestart
IF /i %main%==settings goto suroadbm
:errorm
cls
echo ERROR: The command does not exist or there's a mistype.
echo.
goto menu



:: EXPERIMENTAL!
:wirelsomni
cls
echo Wifi mode is already active and will be applied each time
echo SuroADB is started. If you don't see your device ip in the
echo devices list, you will need to set it up again.
echo.
IF EXIST "%MYFILES%\deviceip.bat" echo Device IP : %deviceip%
echo.
echo What would you like to do?
echo.
echo S - Setup WiFi mode again
echo D - Stop WiFi mode from being started in each start (delete file)
echo X - Go back to menu
echo.
set /p wirelsomnii=S / D / X : 
cls
IF /i %wirelsomnii%==S goto wirelsd
IF /i %wirelsomnii%==D DEL /Q "%audir%\sroadbwifimode.bat"
IF /i %wirelsomnii%==D goto clsmenu
IF /i %wirelsomnii%==X goto clsmenu
goto wirelsomni


:wirels
IF EXIST "%audir%\deviceip.bat" goto wirelsomni
:wirelsd
IF EXIST "%audir%\deviceip.bat" DEL /Q "%audir%\deviceip.bat"
:wirelss
cls
echo Here you can configure ADB to connect to your device via WiFi network.
echo you just need your computer to be on the same network as your device
echo for it to work.
echo.
echo This is very useful for people who don't want their device
echo restricted via usb cable.
echo.
echo Begin setup?
echo.
set /p wirepr= Y / N : 
cls
IF %wirepr%==y goto wirels2
IF %wirepr%==Y goto wirels2
IF %wirepr%==n goto clsmenu
IF %wirepr%==N goto clsmenu
goto wirels


:wirels2
cls
echo SuroADB WiFi mode 1/5
echo.
adb devices
echo.
echo Make sure only one android device with USB debugging is connected to your
echo computer.
echo.
echo Also make sure it's ready for ADB usage, and is connected to the same WiFI
echo network!
echo.
echo If you see your device, press any key to continue.
pause>nul
goto wirels3

:wirels3
cls
echo SuroADB WiFi mode 2/5
echo.
adb tcpip 5555
echo.
echo You may now disconnect your device.
echo.
echo Enter Y to continue, or enter N if you see errors
set /p srowifi= : 
cls
IF /i %srowifi%==Y goto wirels4
IF /i %srowifi%==N goto wirels3
goto wirels3

:wirels4
cls
:wirels411
set wirelesip=none
echo SuroADB WiFI mode 3/5
echo enter menu to abort
echo.
echo Enter your phone's IP address.
echo It can be found in About phone - Phone status
echo.
echo.
echo ex. 122.692.02.123
set /p wirelesip= : 
cls
IF /i %wirelesip%==MENU goto clsmenu
IF /i %wirelesip%==none goto wirels
goto wirels41

:wirels41
cls
echo SuroADB WiFI mode 4/5
echo enter menu to abort
echo.
echo Confirm this IP address?
echo : %wirelesip%
echo.
set /p wireconfirm=Y / N : 
cls
IF /i %wireconfirm%==Y goto wirels5
IF /i %wireconfirm%==N goto wirels4
IF /i %wireconfirm%==MENU goto clsmenu
goto wirels41

:wirels5
(
echo set deviceip=%wirelesip%
) > "%audir%\deviceip.bat"
goto wirels51

:wirels51
cls
echo SuroADB WiFi mode 5/5
echo.
adb connect %wirelesip%:5555
echo.
adb devices
echo.
echo Do you see "%wirelesip%:5555" in the device list?
echo.
set /p wirelsconfirm=Y / N : 
cls
IF /i %wirelsconfirm%==Y goto wirels6
IF /i %wirelsconfirm%==N goto wirels2
goto wirels5

:wirels6
cls
echo Success! You have succesfully configured ADB to
echo connect with your device via WiFI.
echo.
echo Be noted that if your device restarts, you will need
echo to redo all these steps again.
echo.
echo Would you like to always start SuroADB in WiFi
echo mode from now on? (EXPERIMENTAL!)
echo.
set /p wifiset= Y / N : 
cls
IF /i %wifiset%==Y goto wifisetter
IF /i %wifiset%==N goto clsmenu
goto wirels6

:wifisetter
cls
echo set deviceip=%wirelesip% > "%audir%\deviceip.bat"
goto clsmenu





:sandbox1
title SuroADB %version% : adb mode
echo.
set /p sndbx=Enter a command : 
echo.
%sndbx%
goto sandbox1

:shellmode
cls
title SuroADB %version% : adb shell
adb shell
goto shellmode


:op1
cls
adb devices
echo.
goto menu

:: NEW EXPERIMENTAL APK INSTALL SYSTEM
:op2
IF NOT EXIST "%tempdir%\Apk" MKDIR "%tempdir%\Apk"
set apkid=%random%
cls
:op2cl
echo  APK Installation
echo.
echo  Select an option:
echo.
echo  H - Install application normally
echo  S - Install application to sdcard
echo  R - Replace the existing application (for updates)
echo  G - Grant all runtime permissions
echo.
echo  M - Go back to menu
echo.
echo.
set /p pkginstall= : 
cls
IF /i %pkginstall%==H goto apkinstallH
IF /i %pkginstall%==S goto apkinstallS
IF /i %pkginstall%==R goto apkinstallR
IF /i %pkginstall%==G goto apkinstallG
IF /i %pkginstall%==M goto clsmenu
cls
goto op2

:: APK INSTALL TYPES
:apkinstallH
cls
:apkinstallH1
echo Select the APK.
echo.
rem BrowseFiles
cls
IF %result%==0 set opcode=APK File selection.
IF %result%==0 goto opcancel

call :pkgt %result%
exit /b

:pkgt
set pkgname=%~nx1

call :pkgv %result%
exit /b

:pkgv
set pkgex=%~x1

ping localhost -n 2 >nul
IF NOT %pkgex%==.apk goto pkgerror2H

echo Copying to "%instal%" ...
COPY /Y "%RESULT%" "%instal%"
IF NOT EXIST "%instal%\%pkgname%" goto pkgerrorH
RENAME "%instal%\%pkgname%" "%apkid%.apk"
cls
echo Selected : %pkgname%
echo Installing ...
adb install "%instal%\%apkid%.apk"
DEL /Q "%instal%\%apkid%.apk"
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% "%result%" selected for install to device. >> %audir%\sroadb-logs.txt
echo.
goto op2cl

:apkinstallR
cls
:apkinstallR1
echo Select the APK.
echo.
rem BrowseFiles
cls
IF %result%==0 set opcode=APK File selection.
IF %result%==0 goto opcancel
call :pkgts %result%
exit /b

:pkgts
set pkgname=%~nx1

call :pkgvs %result%
exit /b

:pkgvs
set pkgex=%~x1

ping localhost -n 2 >nul
IF NOT %pkgex%==.apk goto pkgerror2R

echo Copying to "%instal%" ...
COPY /Y "%RESULT%" "%instal%"
IF NOT EXIST "%instal%\%pkgname%" goto pkgerrorR
RENAME "%instal%\%pkgname%" "%apkid%.apk"
cls
echo Selected : %pkgname%
echo Installing ...
adb install -s "%instal%\%apkid%.apk"
DEL /Q "%instal%\%apkid%.apk"
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% "%result%" selected for install to device. >> %audir%\sroadb-logs.txt
echo.
goto op2cl

:apkinstallS
cls
:apkinstallS1
echo Select the APK.
echo.
rem BrowseFiles
cls
IF %result%==0 set opcode=APK File selection.
IF %result%==0 goto opcancel
call :pkgts %result%
exit /b

:pkgts
set pkgname=%~nx1

call :pkgvs %result%
exit /b

:pkgvs
set pkgex=%~x1

ping localhost -n 2 >nul
IF NOT %pkgex%==.apk goto pkgerror2S

echo Copying to "%instal%" ...
COPY /Y "%RESULT%" "%instal%"
IF NOT EXIST "%instal%\%pkgname%" goto pkgerrorS
RENAME "%instal%\%pkgname%" "%apkid%.apk"
cls
echo Selected : %pkgname%
echo Installing ...
adb install -s "%instal%\%apkid%.apk"
DEL /Q "%instal%\%apkid%.apk"
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% "%result%" selected for install to device. >> %audir%\sroadb-logs.txt
echo.
goto op2cl

:apkinstallG
cls
:apkinstallG1
echo Select the APK.
echo.
rem BrowseFiles
cls
IF %result%==0 set opcode=APK File selection.
IF %result%==0 goto opcancel

call :pkgtg %result%
exit /b

:pkgtr
set pkgname=%~nx1

call :pkgvg %result%
exit /b

:pkgvr
set pkgex=%~x1

ping localhost -n 2 >nul
IF NOT %pkgex%==.apk goto pkgerror2G

echo Copying to "%instal%" ...
COPY /Y "%RESULT%" "%instal%"
IF NOT EXIST "%instal%\%pkgname%" goto pkgerrorG
RENAME "%instal%\%pkgname%" "%apkid%.apk"
cls
echo Selected : %pkgname%
echo Installing ...
adb -g install %instal%\%apkid%.apk"
DEL /Q "%instal%\%apkid%.apk"
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% "%result%" selected for install to device. >> "%audir%\sroadb-logs.txt"
echo.
goto op2cl

:: END
:: ERRORS
:pkgerrorH
cls
echo An error has occured while copying the APK to a temp folder.
echo.
echo Please rename your APK to something that does not contain
echo spaces, then try again.
echo.
goto apkinstallH1
:pkgerrorS
cls
echo An error has occured while copying the APK to a temp folder.
echo.
echo Please rename your APK to something that does not contain
echo spaces, then try again.
echo.
goto apkinstallS1
:pkgerrorR
cls
echo An error has occured while copying the APK to a temp folder.
echo.
echo Please rename your APK to something that does not contain
echo spaces, then try again.
echo.
goto apkinstallR1
:pkgerrorG
cls
echo An error has occured while copying the APK to a temp folder.
echo.
echo Please rename your APK to something that does not contain
echo spaces, then try again.
echo.
goto apkinstallG1

:pkgerror2H
cls
echo Error: Please choose a .APK file.
goto apkinstallH1
:pkgerror2S
cls
echo Error: Please choose a .APK file.
goto apkinstallS1
:pkgerror2R
cls
echo Error: Please choose a .APK file.
goto apkinstallR1
:pkgerror2G
cls
echo Error: Please choose a .APK file.
goto apkinstallG1

:: APP INSTALL END


:op3
cls
goto op33
:op33
echo Enter the package name. ex. com.test.app
echo enter menu to go back to menu
echo 
echo.
set /p unpackage= : 
cls
if %unpackage%==menu goto clsmenu
if %unpackage%==MENU goto clsmenu
adb uninstall %unpackage%
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% "%unpackage%" selected for uninstallation. >> "%audir%\sroadb-logs.txt"
echo.
goto op33

:op4
set exportpackage=no
cls
echo.
adb shell pm list packages
echo.
IF EXIST %audir%\sroadbexportpk.bat call "%audir%\sroadbexportpk.bat"
IF %exportpackage%==yes goto pkgexport
echo Would you like to export the list to
echo %audir%\package-list.txt? 
echo.
set /p pckg=Y / N : 
cls
IF %pckg%==y goto pkgexport
IF %pckg%==n goto clsmenu
IF %pckg%==Y goto pkgexport
IF %pckg%==n goto clsmenu
goto op4
:op4n
cls
IF %exportpackage%==yes goto clsmenu
IF EXIST "%audir%\sroadbexportpk.bat" goto clsmenu
echo.
echo Would you like to always export the package list from now on?
echo.
set /p opno=Y / N : 
cls
IF %opno%==y goto epkg
IF %opno%==n goto clsmenu
IF %opno%==Y goto epkg
IF %opno%==N goto clsmenu
goto clsmenu
:epkg
ping localhost -n 2 >nul
cls
(
echo set exportpackage=yes
echo exit /b
) > "%audir%\sroadbexportpk.bat"
goto clsmenu

:pkgexport
cls
(
echo ==========LIST START==========
echo.
adb shell pm list packages
echo.
echo This list was generated by SuroADB at %DATE% : %TIME%
echo.
echo ==========LIST END==========
) >> "%audir%\package-list.txt"
start "%SystemRoot%\notepad.exe" "%audir%\package-list.txt"
cls
goto op4n

:op5
set pullf=%sdconfig%
cls
:op5c
echo Enter the path to the file/folder that you want to
echo copy to your computer.
echo.
echo ex. %sdconfig%/video.mp4
echo.
echo Enter menu to go back to menu.
echo.
set /p pullf= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
IF /i %pullf%==MENU goto clsmenu
cls
echo Select the folder where "%pullf%" will be copied to.
rem BrowseFolder
cls
IF %result%==0 set opcode=File pull destination.
IF %result%==0 goto op5
echo Copying : %pullf%
echo To : %result%
echo.
adb pull "%pullf%" "%result%"
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% "%pullf%" copied to "%result%". >> %audir%\sroadb-logs.txt
echo.
goto op5c


:op6
IF NOT EXIST "%wdre%\sroadbtemp\SuroADB" MKDIR "%wdre%\sroadbtemp\SuroADB"
IF NOT EXIST "%wdre%\sroadbtemp\Push" MKDIR "%wdre%\sroadbtemp\Push"
cls
:op61
set pushf=NO FILE/FOLDER SELECTED
echo What do you want to copy to your device?
echo.
set /p pushf1=folder / file / menu : 
cls
IF /i %pushf1%==FOLDER goto pushf2
IF /i %pushf1%==FILE goto pushf3
IF /i %pushf1%==MENU goto clsmenu
goto op6

:pushf2
cls
set pushff1=folder
echo Select the folder.
echo Note: Rename the folder if it has spaces to avoid errors.
rem BrowseFolder
IF %result%==0 set opcode=Push folder selection.
IF %result%==0 goto op6
goto pushffo


:: Original file push handler, will be used until a fix for the new one will be made.
:pushf3
cls
set pushff1=file
echo Select the file
echo Note: Rename the file if it has spaces to avoid errors.
:pushf33
rem BrowseFiles
IF %result%==0 set opcode=Push file selection.
IF %result%==0 goto op6
ping localhost -n 2 >nul
call :pushnm %result%
exit /b
:pushnm
set pusname=%~nx1
COPY /Y "%RESULT%" "%wdre%\sroadbtemp\Push"
cls
IF NOT EXIST "%wdre%\sroadbtemp\Push\%pusname%" goto puserror
set pushfvar=%result%
goto pushnative2



:: New experimental file push handler that supports spaces! (BROKEN !)
:: file copies to temp folder (even with spaces) but it cant copy in adb.
::pushf3
cls
set pushff1=file
echo Select the file
::pushf33
rem BrowseFiles
IF %result%==0 set opcode=Push file selection.
IF %result%==0 goto op6
ping localhost -n 2 >nul

set pfpath=%result%
set pfpath2=%result%

call :pushnm %pfpath%
exit /b

:pushnm
set pusname=%~nx1

call :pushpath %pfpath2%
exit /b

::pushpath
set puspath=%~dp1

cls
echo Preparing for file push..
COPY /Y "%puspath%%pusname%" "%wdre%\sroadbtemp\Push" >nul
cls
IF NOT EXIST "%wdre%\sroadbtemp\Push\%pusname%" goto puserror
set pushfvar=%result%
goto pushnative2


:: Used by folder push
:pushffo
cls
echo Selected : %result%
echo.
echo Enter the path to where the folder should go
echo ex. %sdconfig%/folders
echo.
set /p pushf= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo Copying : %result%
echo To : %pushf%
echo.
adb push "%result%" "%pushf%"
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% "%result%" copied to "%pushf%". >> "%audir%\sroadb-logs.txt"
echo.
goto op61

:: Original File push system for the old file push handler. - being used by all file push operations
:pushnative2
IF NOT EXIST "%tempdir%\Push" MKDIR "%tempdir%\Push"
set pushf=%sdconfig%
echo Selected : %pushfvar%
echo.
echo Enter the path to where the file should go.
echo ex. %sdconfig%/files
echo.
echo.
set /p pushf= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
cls
echo Copying : %pushfvar%
echo To : %pushf%
adb push "%tempdir%\Push\%pusname%" "%pushf%"
RD /S /Q %tempdir%\Push >nul
IF NOT EXIST "%tempdir%\Push" MKDIR "%tempdir%\Push"
IF %logst%==YES echo %TIME% %DATE% "%result%" copied to "%pushf%". >> "%audir%\sroadb-logs.txt"
echo.
goto op61

:: New file push handler's file push executer -unused
::pushnative2
IF NOT EXIST "%tempdir%\Push" MKDIR "%tempdir%\Push"
set pushf=%sdconfig%
echo Selected : %pushfvar%
echo.
echo Enter the path to where the file should go.
echo ex. %sdconfig%/files
echo.
echo.
set /p pushf= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
cls
echo Copying : %pushfvar%
echo To : %pushf%
adb push "%puspath%\"%pusname%"" "%pushf%"
RD /S /Q "%wdre%\sroadbtemp\Push"
IF NOT EXIST "%tempdir%\Push" MKDIR "%tempdir%\Push"
IF %logst%==YES echo %TIME% %DATE% "%result%" copied to "%pushf%". >> "%audir%\sroadb-logs.txt"
echo.
goto op61

:puserror
(
echo %TIME% file push error
echo ==data==
echo File: %pusname%
echo Destination: %pushf%
echo Source: %result%
echo ==end==
) >> "%audir%\sroadb-errorlog.txt"
cls
echo Error while copying the file to a temp folder.
echo.
echo Please rename your file to something that
echo does not contain s p a c e s, then try again.
echo.
echo OR move the file to a folder, then use the folder push method.
echo.
goto op61


:op51
cls
set screen=adbscreenshot-%random%-%sessionid%.png
echo A screenshot of your device screen will be taken.
echo.
echo Enter the desired file name. ex. screen.png
echo (avoid spaces and include .png!)
echo.
echo Enter MENU to go back to menu.
echo.
set /p screen= : 
cls
IF /i %screen%==menu goto clsmenu
IF EXIST "%audir%\sroadbsspath.bat" call "%audir%\sroadbsspath.bat"
IF EXIST "%audir%\sroadbsspath.bat" goto scrsp1
echo Where should the screenshot file go?
echo. enter the path. ex. %sdconfig%/screenshots
echo.
set /p scrsp= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
:scrsp1
adb shell screencap "%scrsp%"/%screen%
echo Screenshot %screen% saved to %scrsp%.
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% screenshot "%screen%" saved to "%scrsp%". >> "%audir%\sroadb-logs.txt"
:scrp2
IF EXIST "%audir%\sroadbsspath.bat" goto scrsps
cls
echo Would you like to set %scrsp% as a default save path from now on?
echo.
set /p scrsv=Y / N : 
cls
IF %scrsv%==y goto scrspp
IF %scrsv%==Y goto scrspp
IF %scrsv%==n goto scrsps
IF %scrsv%==N goto scrsps
goto scrp2

:scrspp
ping localhost -n 2 >nul
cls
(
echo set scrsp=%scrsp%
echo exit /b
) > "%audir%\sroadbsspath.bat"
goto scrsps

:scrsps
cls
echo Would you like to copy %screen% to your computer?
echo.
set /p screens=Y / N :
cls
IF /i %screens%==Y goto opsy
IF /i %screens%==N goto clsmenu
goto scrsps

:op52
set scrsi=1280x720
set scrti=180
IF EXIST "%audir%\adbrecordsize.bat" call "%audir%\adbrecordsize.bat"
IF EXIST "%audir%\adbrecordtime.bat" call "%audir%\adbrecordtime.bat"
cls
echo Device Screen recording (size: %scrsi% time: %scrti% seconds)
echo.
echo Would you like to set up output resolution and time limit?
echo.
echo  Y - set up
echo  N - use current settings
echo  X - go back to menu
echo.
echo.
set /p scrm= : 
cls
echo.
IF /i %scrm%==Y goto scrmy
IF /i %scrm%==N goto op522
IF /i %scrm%==X goto clsmenu
goto op52

:scrmy
cls
echo Device Screen recording setup 1 (size: %scrsi% time: %scrti% seconds)
echo.
echo Set the desired recording resolution. ex. 1280x720 (default)
echo leave empty to continue with current resolution.
echo.
echo.
set /p scrsi= : 
cls
ping localhost -n 2 >nul
cls
(
echo set scrsi=%scrsi%
echo exit /b
) > "%audir%\adbrecordsize.bat"
echo.
cls
echo Device Screen recording setup 2 (size: %scrsi% time: %scrti% seconds)
echo.
echo Set how many seconds to record. Maximum is 180 seconds (maximum and default)
echo leave empty to continue with current time limit.
echo.
echo.
set /p scrti= : 
cls
ping localhost -n 2 >nul
cls
(
echo set scrti=%scrti%
echo exit /b
) > "%audir%\adbrecordtime.bat"
echo.
:scrrdy
cls
echo Device Screen recording READY
echo.
echo Resolution: %scrsi% Time: %scrti% seconds.
echo Is this okay?
echo.
echo  Y  to continue  N  to start again
echo.
echo.
set /p scrmyy= Y / N : 
cls
echo.
IF %scrmyy%==Y goto op522
IF %scrmyy%==N goto scrmy
IF %scrmyy%==y goto op522
IF %scrmyy%==n goto scrmy
goto scrrdy

:op522
cls
echo Begin screen recording? (size: %scrsi% time: %scrti% seconds.)
echo.
echo  Y - begin
echo  S - configure settings
echo  X - go back to menu
echo.
echo.
set /p scrbegin= : 
cls
echo.
IF /i %scrbegin%==Y goto scrbegin1
IF /i %scrbegin%==N goto op52
IF /i %scrbegin%==S goto scrmy
IF /i %scrbegin%==X goto clsmenu
goto op522

:scrbegin1
IF EXIST "%audir%\sroadbsrpath.bat" call "%audir%\sroadbsrpath.bat"
cls
echo Enter desired filename. ex. record.mp4
echo (avoid spaces and include .mp4!)
echo.
set /p scrbegin2= : 
cls
:scrbegin11
IF EXIST "%audir%\sroadbsrpath.bat" goto scrp3
echo  Enter the path to where the file should go.
echo  ex. %sdcard%
echo.
set /p scrp= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
:scrp22
cls
echo Would you like to set %scrp% as a default save path from now on?
echo.
set /p scrrv=Y / N : 
cls
IF /i %scrrv%==Y goto scrspp
IF /i %scrrv%==N goto scrp3
goto scrp22

:scrspp
ping localhost -n 2 >nul
cls
(
echo set scrsp=%scrp%
echo exit /b
) > "%audir%\sroadbsrpath.bat"
goto scrp3

:scrp3
cls
echo Recording %scrti% seconds. File will be saved to "%scrp%"
adb shell screenrecord --size %scrsi% --time-limit %scrti% "%scrp%"/%scrbegin2%
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% screen recording "%scrbegin2%" saved to "%scrsp%". >> "%audir%\sroadb-logs.txt"
:scrp31
cls
echo  Success. Would you like to copy %scrbegin2% to your computer?
echo.
echo.
set /p scrend= Y / N : 
cls
IF /i %scrend%==Y goto scrend1
IF /i %scrend%==N goto op52
goto scrp31

:scrend1
cls
echo  Select the destination path.
rem BrowseFolder 
IF %result%==0 set opcode=Screen record file push destination.
IF %result%==0 goto opcancel
adb pull %scrp%/%scrbegin2% "%result%"
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% "%scrsp%/%scrbegin2%" copied to "%result%". >> "%audir%\sroadb-logs.txt"
echo.
goto op52

:opsy
cls
echo Select the destination path.
rem BrowseFolder
IF %result%==0 set opcode=Screenshot file push destination.
IF %result%==0 goto opcancel
adb pull %scrsp%/%screen% "%result%"
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% "%scrsp%/%screen%" copied to "%result%". >> "%audir%\sroadb-logs.txt"
echo.
goto op51

:op7
cls
echo Are you sure you want to turn off device?
echo.
set /p shutp=Y / N : 
cls
if /i %shutp%==Y goto op71
if /i %shutp%==N goto umenu
goto op7

:op71
cls
echo Shutting down device..
ping localhost -n 3 >nul
adb shell reboot -p
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% device shutdown. >> "%audir%\sroadb-logs.txt"
ping localhost -n 2 >nul
echo Success.
goto menu

:op8
cls
echo Choose where to reboot:
echo.
echo SYSTEM
echo RECOVERY
echo BOOTLOADER
echo.
echo menu
echo.
set /p rebop= : 
cls
IF /i %rebop%==SYSTEM goto op81
IF /i %rebop%==RECOVERY goto recv
IF /i %rebop%==BOOTLOADER goto btld
IF /i %rebop%==MENU goto clsmenu
goto op8

:op81
cls
echo Restarting device..
ping localhost -n 3 >nul
adb shell reboot
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% device reboot. >> "%audir%\sroadb-logs.txt"
ping localhost -n 3 >nul
echo Success.
echo.
goto menu

:recv
cls
echo Rebooting to Recovery...
ping localhost -n 3 >nul
adb shell reboot recovery
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% device reboot to recovery. >> "%audir%\sroadb-logs.txt"
ping localhost -n 3 >nul
echo Success.
echo.
goto menu

:btld
cls
echo Rebooting to Bootloader...
ping localhost -n 3 >nul
adb shell reboot bootloader
IF %logst%==YES set /A entries=%entries% + 1
IF %logst%==YES echo %TIME% %DATE% device reboot to bootloader. >> "%audir%\sroadb-logs.txt"
ping localhost -n 3 >nul
echo Success.
echo.
goto menu

:: Help menu is currently outdated <11
::updated on ver11>

:helpmenu
IF EXIST "%audir%\sroadbuic.txt" goto chelpmenu
echo What do you need help with?
echo enter menu to go back to menu.
echo.
echo     devices
echo     install
echo     uninstall
echo     packages
echo     pull
echo     push
echo     screenshot
echo     screenrecord
echo     poweroff
echo     reboot
echo.
echo     adb
echo     shell
echo     wifi
echo.
echo.
set /p helpnemu= : 
echo.
IF /i %helpnemu%==devices goto h1
IF /i %helpnemu%==install goto h2
IF /i %helpnemu%==uninstall goto h3
IF /i %helpnemu%==packages goto h4
IF /i %helpnemu%==pull goto h5
IF /i %helpnemu%==push goto h5
IF /i %helpnemu%==screenshot goto h6
IF /i %helpnemu%==screenrecord goto h7
IF /i %helpnemu%==poweroff goto h8
IF /i %helpnemu%==reboot goto h8
IF /i %helpnemu%==adb goto hadb
IF /i %helpnemu%==menu goto clsmenu
IF /i %helpnemu%==shell goto hshell
IF /i %helpnemu%==wifi goto whelp
goto helpmenu


:chelpmenu
echo What do you need help with?
echo enter menu to go back to menu.
echo.
echo     devices
echo     install : uninstall : packages
echo     pull : push
echo     screenshot : screenrecord
echo     poweroff : reboot
echo.
echo     adb : shell : wifi
echo.
echo.
set /p helpnemu= : 
echo.
IF /i %helpnemu%==devices goto h1
IF /i %helpnemu%==install goto h2
IF /i %helpnemu%==uninstall goto h3
IF /i %helpnemu%==packages goto h4
IF /i %helpnemu%==pull goto h5
IF /i %helpnemu%==push goto h5
IF /i %helpnemu%==screenshot goto h6
IF /i %helpnemu%==screenrecord goto h7
IF /i %helpnemu%==poweroff goto h8
IF /i %helpnemu%==reboot goto h8
IF /i %helpnemu%==adb goto hadb
IF /i %helpnemu%==menu goto clsmenu
IF /i %helpnemu%==shell goto hshell
IF /i %helpnemu%==wifi goto whelp
cls
goto chelpmenu






:whelp
cls
echo Help : "wifi"
echo.
echo Here you can configure ADB to communicate
echo with your device via wireless connection such
echo as a wifi hotspot. There's also an experimental
echo "auto" mode that can automatically configure
echo each time SuroADB is started.
echo.
goto helpmenu


:hadb
cls
echo Help : "adb"
echo.
echo Here you can enter any adb commands and batch commands.
echo it is advisable to use it only if you know what you're doing.
echo.
goto helpmenu

:hshell
cls
echo Help : "shell"
echo.
echo This starts adb in shell mode, where you can enter adb shell commands.
echo it is advisable to use it only if you know what you're doing.
echo.
goto helpmenu

:h1
cls
echo Help : "devices"
echo.
echo This will display all devices currently connected
echo to your computer. If your device is not found, be
echo sure to have proper ADB drivers installed and have
echo USB debugging enabled.
echo.
goto helpmenu

:h2
cls
echo Help : "install"
echo.
echo This will install an APK file that you selected.
echo.
echo There's also different options for various uses.
echo.
goto helpmenu

:h3
cls
echo Help : "uninstall"
echo.
echo This will uninstall the app that has the package name
echo you entered. If you do not know the package name, you
echo can use the "packages" command.
echo.
goto helpmenu

:h4
cls
echo Help : "packages"
echo.
echo This will display all package names of installed apps.
echo.
echo There's also an auto-export feature to export the lists in
echo a text file.
echo.
goto helpmenu


:h5
cls
echo Help : "pull" and "push"
echo.
echo Pull will download the specified path (folder) or file to
echo your computer. Push goes vice versa.
echo.
echo Currently, SuroADB can't support copying of files and
echo folders with s p a c e s in their names. A workaround
echo for this is to copy the files with spaces into a folder
echo ex. "files" then use the folder push method to copy
echo that folder to your device. This also works with
echo the pull command.
echo.
goto helpmenu

:h6
cls
echo Help : "screenshot"
echo.
echo This will take a screenshot of your device screen.
echo on-screen instructions are available.
echo.
goto helpmenu

:h7
cls
echo Help : "screenrecord"
echo.
echo This will record your device screen.
echo a configuration setup is available to
echo set the size and time of the recording.
echo.
echo Currently, ADB supports a maximum of
echo 180 seconds / 3 minutes for recording.
echo.
goto helpmenu

:h8
cls
echo Help : "poweroff" and "reboot"
echo.
echo "poweroff" shuts down the device.
echo.
echo "reboot" lets you select where to reboot.
echo.
goto helpmenu


:exitp
cls
echo Closing adb.exe ...
taskkill /F /IM adb.exe
exit

:umenu
cls
goto menu


:suroadbm
cls
:suroadbm1
IF EXIST "%audir%\sroadbuic.txt" goto csuroadbm
echo SuroADB Settings
echo.
echo    color (change color scheme)
echo    ui (UI settings)
echo    def (change things to default)
echo    config (sdcard directories)
echo    update
echo    logs (set logging on/off, view all logs)
echo    temp (open the temp/default working directory folder)
echo    troubleshoot
echo    debug
echo    info
echo    readme
echo.
echo    uninstall
echo.
echo    menu 
echo.
echo.
set /p srodb= : 
cls
IF /i %srodb%==update goto updt
IF /i %srodb%==color goto interfacemenu
IF /i %srodb%==ui goto uisettings
IF /i %srodb%==def goto defl
IF /i %srodb%==config goto cfgset
IF /i %srodb%==logs goto logg
IF /i %srodb%==menu goto clsmenu
IF /i %srodb%==info goto faq
IF /i %srodb%==temp start "%SystemRoot%\explorer.exe" "%MYFILES%"
IF /i %srodb%==readme goto rdme
IF /i %srodb%==troubleshoot goto trouble
IF /i %srodb%==debug goto debugm
IF /i %srodb%==uninstall goto srouninstall
goto suroadbm

:csuroadbm
cls
echo SuroADB Settings
echo.
echo    UI Settings:
echo    color : ui
echo.
echo    Defaults, Directories, and Logging:
echo    def : config : temp : logs
echo.
echo    Updates and Troubleshooting:
echo    update : troubleshoot : debug
echo.
echo    Readables:
echo    info : readme
echo.
echo    Uninstall:
echo    uninstall
echo.
echo    menu 
echo.
echo.
set /p srodb= : 
cls
IF /i %srodb%==update goto updt
IF /i %srodb%==color goto interfacemenu
IF /i %srodb%==ui goto uisettings
IF /i %srodb%==def goto defl
IF /i %srodb%==config goto cfgset
IF /i %srodb%==logs goto logg
IF /i %srodb%==menu goto clsmenu
IF /i %srodb%==info goto faq
IF /i %srodb%==temp start "%SystemRoot%\explorer.exe" "%MYFILES%"
IF /i %srodb%==readme goto rdme
IF /i %srodb%==troubleshoot goto trouble
IF /i %srodb%==debug goto debugm
IF /i %srodb%==uninstall goto srouninstall
goto suroadbm


:uisettings
set menuui=ERROR_UNABLE_TO_SET_VARIABLES
IF NOT EXIST "%audir%\sroadbuic.txt" set menuui=COMPACT
IF EXIST "%audir%\sroadbuic.txt" set menuui=ORIGINAL
cls
echo SuroADB UI
echo.
echo  mu - Switches menu UI to %menuui% mode
echo.
echo menu
echo.
set /p sroui= : 
cls
IF /i %sroui%==mu goto muiswitch
IF /i %sroui%==menu goto suroadbm
goto uisettings

:muiswitch
IF %menuui%==COMPACT goto compsw
IF %menuui%==ORIGINAL goto origsw
goto uisettings
:compsw
echo compact > "%audir%\sroadbuic.txt"
goto uisettings
:origsw
DEL /Q "%audir%\sroadbuic.txt"
goto uisettings

:srouninstall
cls
echo Would you like to delete all SuroADB files and data?
echo.
echo Be noted that the pre-compiled files will be extracted again if
echo SuroADB is started.
echo.
echo.
set /p unprompt=Y / N : 
cls
IF /i %unprompt%==Y goto srouninstall2
IF /i %unprompt%==N goto suroadbm
goto srouninstall
:srouninstall2
cls
echo Are you sure? All data and preferences will be deleted!
echo.
echo.
set /p unpromptq=Y / N : 
cls
IF /i %unpromptq%==Y goto srouninstall3
IF /i %unpromptq%==N goto suroadbm
goto srouninstall2
:srouninstall3
CD "%MYFILES%"
cls
echo A1 Closing adb.exe (adb daemon)
taskkill /F /IM adb.exe >nul
echo A2 Closing adb.exe (2)
taskkill /F /IM adb.exe >nul
echo A3 Closing download.exe (update checker process)
taskkill /F /IM download.exe >nul
echo A4 Closing download.exe (2)
taskkill /F /IM download.exe >nul
ping localhost 3 -n >nul
echo B1 Deleting adb resources
DEL /Q "%MYFILES%\adb.exe"
DEL /Q "%MYFILES%\AdbWinApi.dll"
DEL /Q "%MYFILES%\AdbWinUsbApi.dll"
DEL /Q "%MYFILES%\dmtracedump.exe"
DEL /Q "%MYFILES%\download.exe"
DEL /Q "%MYFILES%\etc1tool.exe"
DEL /Q "%MYFILES%\fastboot.exe"
DEL /Q "%MYFILES%\hprof-conv.exe"
DEL /Q "%MYFILES%\libwinpthread-1.dll"
DEL /Q "%MYFILES%\make_f2fs.exe"
DEL /Q "%MYFILES%\mke2fs.exe"
DEL /Q "%MYFILES%\mke2fs.conf"
DEL /Q "%MYFILES%\source.properties"
DEL /Q "%MYFILES%\sqlite3.exe"
echo B2 Deleting SuroADB resources
DEL /Q "%MYFILES%\sroadb%filerawver%w.txt"
DEL /Q "%MYFILES%\sroadbupdate.exe"
DEL /Q "%MYFILES%\sroadbupdateui.bat"
DEL /Q "%MYFILES%\readme-help.txt"
DEL /Q "%MYFILES%\sroadbbetaui.bat"
DEL /Q "%MYFILES%\SuroADB!Beta.exe"
echo B3 Deleting external SuroADB data
IF EXIST "%MYFILES%\updtstop.txt" DEL /Q "%MYFILES%\updtstop.txt"
IF EXIST "%MYFILES%\updatechk.bat" DEL /Q "%MYFILES%\updatechk.bat"
IF EXIST "%MYFILES%\sroadb-debug.txt" DEL /Q "%MYFILES%\sroadb-debug.txt"
IF EXIST "%MYFILES%\sroadb-errorlog.txt" DEL /Q "%MYFILES%\sroadb-errorlog.txt"
IF EXIST "%MYFILES%\sroadbdb.bat" DEL /Q "%MYFILES%\sroadbdb.bat"
echo C1 Deleting temp data folder
RD /S /Q "%tempdir%"
echo C2 Deleting SuroADB settings and log file folder
RD /S /Q "%audir%"
:uver1
echo D1 Checking
IF EXIST "%MYFILES%\adb.exe" goto unerror
IF EXIST "%MYFILES%\AdbWinApi.dll" goto unerror
IF EXIST "%MYFILES%\AdbWinUsbApi.dll" goto unerror
IF EXIST "%MYFILES%\dmtracedump.exe" goto unerror
IF EXIST "%MYFILES%\download.exe" goto unerror
IF EXIST "%MYFILES%\etc1tool.exe" goto unerror
IF EXIST "%MYFILES%\fastboot.exe" goto unerror
IF EXIST "%MYFILES%\hprof-conv.exe" goto unerror
IF EXIST "%MYFILES%\libwinpthread-1.dll" goto unerror
IF EXIST "%MYFILES%\make_f2fs.exe" goto unerror
IF EXIST "%MYFILES%\mke2fs.exe" goto unerror
IF EXIST "%MYFILES%\source.properties" goto unerror
IF EXIST "%MYFILES%\sqlite3.exe" goto unerror
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" goto unerror
IF EXIST "%MYFILES%\sroadbupdate.exe" goto unerror
IF EXIST "%MYFILES%\sroadbupdateui.bat" goto unerror
IF EXIST "%MYFILES%\readme-help.txt" goto unerror
IF EXIST "%MYFILES%\updtstop.txt" goto unerror
IF EXIST "%MYFILES%\updatechk.bat" goto unerror
IF EXIST "%MYFILES%\sroadb-debug.txt" goto unerror
IF EXIST "%MYFILES%\sroadb-errorlog.txt" goto unerror
IF EXIST "%MYFILES%\sroadbbetaui.bat" goto unerror
IF EXIST "%MYFILES%\SuroADB!Beta.exe" goto unerror
IF EXIST "%tempdir%" goto unerror
IF EXIST "%audir%" goto unerror
IF EXIST "%MYFILES%\sroadbdb.bat" goto unerror
goto undone
:undone
title Goodbye :(
echo.
echo Done.
echo.
echo See you next time.
echo.
pause >nul
cls
exit

:unerror
echo An error has occured while deleting a file/folder!
echo.
echo Delete remaining files manually, or retry uninstall process.
echo.
start "%MYFILES%"
pause
exit

:trouble
set troubles=cd
cls
:troble2
echo What should be fixed?
echo.
echo  cd  : 'adb is not recognized as an internal command'
echo  rd  : change working directory
echo  xx  : revert to default working directory
echo.
echo  ex  : return to menu
set /p troubles= : 
cls
IF /i %troubles%==cd goto repathq
IF /i %troubles%==rd goto repath1
IF /i %troubles%==ex goto suroadbm
IF /i %troubles%==xx goto cdef
goto trouble

:cdef
cls
cd "%MYFILES%"
echo Working directory set to %MYFILES%
DEL /Q "%audir%D\sroadbcd.bat"
goto trouble

:repathq
cls
echo Be sure to that adb.exe is available in
echo the temp folder, then enter "xx" to
echo reset the working directory to MYFILES.
echo.
echo You can also try uninstalling SuroADB
echo via settings - uninstall, then running
echo SuroADB again. If the problem persists,
echo contact me via suroadb.jimdofree.com/contact/
echo and i'll help you.
echo.
goto troble2

:repath1
cls
echo Working directory changer
echo.
echo NOTE:  Working directory changing is obsolete and unstable!
echo SuroADB relies heavily on it's default working directory
echo because auto-restore files and other functions are
echo hard-coded with it. Do not expect everything to work fine
echo after changing! If you encounter problems, revert to default.
echo.
echo Current working directory:
cd
echo.
echo Change it now?
echo.
set /p rpth= Y / N : 
IF %rpth%==y goto repath2
IF %rpth%==Y goto repath2
IF %rpth%==n goto trouble
IF %rpth%==N goto trouble
goto repath1

:repath2
cls
:repath3
echo Choose the new working directory.
echo.
echo.
REM BrowseFolder
IF %result%==0 set opcode=Working Directory reset.
IF %result%==0 goto opcancel
ping localhost -n 2 >nul
COPY /Y "%MYFILES%" "%result%"
cls
cd %result%
IF NOT "%cd%"=="%result%" echo Error! Path is read protected or it's not in %HOMEDRIVE% drive
IF NOT "%cd%"=="%result%" echo Please select a different directory that's in the %HOMEDRIVE% drive.
IF NOT "%cd%"=="%result%" echo.
IF NOT "%cd%"=="%result%" goto repath3
ping localhost -n 2 >nul
cls
(
echo set sroadbcd=%result%
echo exit /b
) > "%audir%\sroadbcd.bat"
cls
echo Success. SuroADB will now CD to this directory
echo in each start.
echo.
pause
goto clsmenu

:cfgset
set sdconfig=NOT_SET
set exsdconfig=NOT_SET
IF EXIST "%audir%\sroadbsdconfig.bat" call "%audir%\sroadbsdconfig.bat"
IF EXIST "%audir%\sroadbexsdconfig.bat" call "%audir%\sroadbexsdconfig.bat"
cls
echo SuroADB Path Configs
echo.
echo What would you like to do?
echo.
echo SD - Change the internal storage path (%sdconfig%)
echo EX - Change the external storage path (%exsdconfig%)
echo menu
echo.
set /p cfgsett= : 
cls
IF /i %cfgsett%==SD goto incfg
IF /i %cfgsett%==EX goto excfg
IF /i %cfgsett%==menu goto suroadbm
goto cfgset

:incfg
cls
echo Enter the path to your INTERNAL storage. (ex. /sdcard)
echo.
echo Please do not close it with a slash ( / ) at the end.
echo.
set /p sdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set sdconfig=%sdconfig% > "%audir%\sroadbsdconfig.bat"
goto cfgset
:excfg
cls
echo Enter the path to your EXTERNAL storage. (ex. /storage/sdcard0)
echo.
echo Please do not enclose it with a slash ( / ) at the end.
echo.
set /p exsdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
echo set exsdconfig=%exsdconfig% > "%audir%\sroadbexsdconfig.bat"
goto cfgset


:debugm
cls
echo SuroADB will run adb devices, then export results to:
echo %wdre%\sroadb-debug.txt
echo.
echo Before continuing, please make sure your device is ready for ADB usage.
echo.
set /p debugp=Y / X : 
IF %debugp%==Y goto debugm1
IF %debugp%==y goto debugm1
IF %debugp%==X goto suroadbm
IF %debugp%==x goto suroadbm
goto debugm


:: Needs more work
:debugm1
cls
if exist "%SystemRoot%\Sysnative\" goto Wind64
set wbit=32bit
goto debugm2
:Wind64
set wbit=64bit
goto debugm2
:debugm2
IF NOT EXIST "%tempdir%\SuroADB-DEBUG" MKDIR "%tempdir%\SuroADB-DEBUG"
IF NOT EXIST "%audir%\sroadbsdconfig.bat" goto debugsd
echo suroadb %version% > "%tempdir%\SuroADB-DEBUG\sroadbdebugtest.txt"
adb devices
adb push "%tempdir%\SuroADB-DEBUG\sroadbdebugtest.txt" "/sdcard"
cls
(
echo SuroADB Version %version% DEBUG
echo.
echo Test time : %DATE% %TIME%
echo.
echo %wbit%
echo Default WD : %wdre%
echo Custom WD : %cd%
echo.
echo ==================
echo ADB DEVICES test
adb devices
echo ==================
) >> "%wdre%\sroadb-debug.txt"
goto suroadbm



:rdme
start "%SystemRoot%\notepad.exe" "%MYFILES%\readme-help.txt"
goto suroadbm

:logg
cls
echo Logging is %logst%. What would you like to do?
echo Note: Error logging will always be on.
echo.
echo   sw - switch status
echo   vi   - view all log files
echo   xx  - go back
echo.
set /p logq= : 
IF /i %logq%==sw goto switch
IF /i %logq%==vi start "%SystemRoot%\explorer.exe" "%audir%"
IF /i %logq%==xx goto suroadbm
goto logg
:switch
cls
IF %logst%==YES goto logno
IF %logst%==NO goto logyes
:logyes
IF EXIST "%audir%\sroadblogs.bat" DEL /Q "%audir%\sroadblogs.bat"
set logst=YES
cls
goto logg
:logno
IF NOT EXIST "%audir%\sroadblogs.bat" goto lognoo
:lognoo
ping localhost -n 2 >nul
cls
(
echo set logst=NO
echo exit /b
) > "%audir%\sroadblogs.bat"
set logst=NO
cls
goto logg

:defl
cls
echo What would you like restored?
echo.
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" echo sv - First run setup (Welcome message)
IF EXIST "%audir%\sroadbcd.bat" echo wd - Working Directory
IF EXIST "%audir%\sroadblogs.bat" echo log - Log setting (Enable logging)
IF EXIST "%audir%\sroadbcol.bat" echo col - Color Scheme
IF EXIST "%audir%\sroadbexportpk.bat" echo ppu - Packages "always export list?" dialog
IF EXIST "%audir%\adbrecordsize.bat" echo srs - Screen recording remember size
IF EXIST "%audir%\adbrecordtime.bat" echo srt - Screen recording remember time
IF EXIST "%audir%\sroadbsrpath.bat" echo srv - Screen recording remember save path dialog
IF EXIST "%audir%\sroadbsspath.bat" echo ssv - Screenshot remember save path dialog
IF EXIST "%audir%\sroadbsdconfig.bat" echo sd - Internal storage path config
IF EXIST "%audir%\sroadbexsdconfig.bat" echo ex - External storage path config
IF EXIST "%MYFILES%\updtstop.txt" echo udt - Update checking
echo all - Set everything as default
echo.
echo.
echo menu
echo.
set /p def11= : 
IF /i %def11%==sv DEL /Q "%MYFILES%\sroadb%filerawver%w.txt"
IF /i %def11%==sw DEL /Q "%audir%\sroadbcd.bat"
IF /i %def11%==log set logst=YES
IF /i %def11%==log DEL /Q "%audir%\sroadblogs.bat"
IF /i %def11%==col set diode=f0
IF /i %def11%==col DEL /Q "%audir%\sroadbcol.bat"
IF /i %def11%==srs DEL /Q "%audir%\adbrecordsize.bat"
IF /i %def11%==srt DEL /Q "%audir%\adbrecordtime.bat"
IF /i %def11%==srv DEL /Q "%audir%\sroadbsrpath.bat"
IF /i %def11%==ssv DEL /Q "%audir%\sroadbsspath.bat"
IF /i %def11%==ppu DEL /Q "%audir%\sroadbexportpk.bat"
IF /i %def11%==sd DEL /Q "%audir%\sroadbsdconfig.bat"
IF /i %def11%==ex DEL /Q "%audir%\sroadbexsdconfig.bat"
IF /i %def11%==udt DEL /Q "%MYFILES%\updtstop.txt"
IF /i %def11%==all goto def12
IF /i %def11%==menu goto suroadbm
:restt
echo.
echo Restarting SuroADB..
ping localhost -n 3 >nul
cls
goto launch

:def12
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" echo SuroADB First run restored
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" DEL /Q "%MYFILES%\sroadb%filerawver%w.txt"
IF EXIST "%audir%\sroadbcd.bat" echo SuroADB Working directory set to %audir%
IF EXIST "%audir%\sroadbcd.bat" cd "%audir%"
IF EXIST "%audir%\sroadbcd.bat" DEL /Q "%audir%\sroadbcd.bat "
IF EXIST "%audir%\sroadbcol.bat" set diode=f0
IF EXIST "%audir%\sroadbcol.bat" echo SuroADB Color scheme set to f0
IF EXIST "%audir%\sroadbcol.bat" DEL /Q "%audir%\sroadbcol.bat"
IF EXIST "%audir%\adbrecordtime.bat" echo ADB recording time set to default
IF EXIST "%audir%\adbrecordtime.bat" DEL /Q "%audir%\adbrecordtime.bat"
IF EXIST "%audir%\adbrecordsize.bat" echo ADB recording size set to default
IF EXIST "%audir%\adbrecordsize.bat" DEL /Q "%audir%\adbrecordsize.bat"
IF EXIST "%audir%\sroadblogs.bat" set logst=YES
IF EXIST "%audir%\sroadblogs.bat" echo SuroADB logs enabled
IF EXIST "%audir%\sroadblogs.bat" DEL /Q "%audir%\sroadblogs.bat"
IF EXIST "%audir%\sroadbexportpk.bat" echo Packages always export list dialog restored
IF EXIST "%audir%\sroadbexportpk.bat" DEL /Q "%audir%\sroadbexportpk.bat"
IF EXIST "%audir%\sroadbsrpath.bat" echo Screen recording save path remember dialog restored
IF EXIST "%audir%\sroadbsrpath.bat" DEL /Q "%audir%\sroadbsrpath.bat"
IF EXIST "%audir%\sroadbsspath.bat" echo Screenshot save path remember dialog restored
IF EXIST "%audir%\sroadbsspath.bat" DEL /Q "%audir%\sroadbsspath.bat"
IF EXIST "%MYFILES%\updtstop.txt" echo Update checking restored
IF EXIST "%MYFILES%\updtstop.txt" DEL /Q "%MYFILES%\updtstop.txt"
IF EXIST "%audir%\sroadbsdconfig.bat" echo Internal storage path config reset
IF EXIST "%audir%\sroadbsdconfig.bat" DEL /Q "%audir%\sroadbsdconfig.bat"
IF EXIST "%audir%\sroadbexsdconfig.bat" echo External storage path config reset
IF EXIST "%audir%\sroadbexsdconfig.bat" DEL /Q "%audir%\sroadbexsdconfig.bat"
goto restt



:interfacemenu
cls
echo SuroADB Color setup
echo.
echo Choose a color scheme. ex. 07
echo.
echo  F0 - Eye bleach
echo  0F - Headache9000
echo  0C - Red on black
echo  0D - Purple on Black
echo  50 - THANOS UI THANOS UI
echo  0E - Yellow on Black
echo  E0 - BLACK AND YELLOW BLACK AND YELLOW BLACK AND YEL-
echo  0A - It's hacker time
echo  0B - Iced Neon
echo  FD - Purple Pastel
echo.
echo You may enter your own color combinations as well.
echo Current color scheme is %diode%
echo.
echo Enter MENU to go back.
set /p diodeset= : 
cls
IF /i %diodeset%==MENU goto suroadbm
goto colorsetconfig

:colorsetconfig
cls
(
echo set diode=%diodeset%
echo exit /b
) > "%audir%\sroadbcol.bat"
cls
set diode=%diodeset%
color %diode%
IF %ERRORLEVEL%==1 set rest=cols
IF %ERRORLEVEL%==1 goto restore
goto interfacemenu


:updt
IF EXIST "%wdre%\updtstop.txt" set updtst=ON
IF NOT EXIST "%wdre%\updtstop.txt" set updtst=OFF
cls
:updt1
echo Update checking
echo.
echo This will check if an update exceeding Version %version% is available.
echo.
echo This will also download the latest database.
echo.
echo V - Check for updates
echo Z - Turn automatic update checking %updtst%
echo X - Go back to menu
echo.
echo.
set /p updch= V / Z / X : 
cls
IF /i %updch%==V goto updt1
IF /i %updch%==Z goto updtswitch
IF /i %updch%==X goto suroadbm
goto updt
:updtswitch
IF NOT EXIST "%wdre%\updtstop.txt" goto updt11
IF EXIST "%wdre%\updtstop.txt" goto updt12
echo %TIME% Unable to identify integrity of required files for updtswitch (cannot detect). >> "%audir%\sroadb-errorlog.txt"
goto updt
:updt11
cls
IF NOT EXIST "%wdre%\updtstop.txt" echo This will stop the update check. > updtstop.txt
set updtst=OFF
cls
goto updt
:updt12
cls
IF EXIST "%wdre%\updtstop.txt" DEL /Q "%wdre%\updtstop.txt"
set updtst=ON
cls
goto updt

:updt1
start sroadbupdate.exe
cls
goto updt


:faq
IF EXIST "%tempdir%\SuroADB\sroadb-counter.bat" CALL "%tempdir%\SuroADB\sroadb-counter.bat"
cls
echo.
echo    Thank you for using SuroADB!
echo.
echo    This is a small non-profit project i've been working on since May 20 2018
echo.
echo    It's my first time starting a programming project.
echo    You could say that this is a pointless journey, where I carelessly
echo    work for something very hard, wearing myself out for no profit. 
echo.
echo    But in reality, I learn from what I'm currently doing. And the joy
echo    I get seeing other people using something I worked countless
echo    hours for is the best feeling ever!
echo. 
echo    You are using version %version% Build %betabuild%
echo    You have used SuroADB %trost% times so far.
echo.
echo    suroadb.jimdofree.com
echo    kutsuro.simdif.com
echo.
echo    2018 Matt "Kutsuro"
echo.
echo    Email: hsudoru@gmail.com
echo.
pause
cls
goto suroadbm