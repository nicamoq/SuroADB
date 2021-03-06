@echo off


:versioninfo
:: VERSION INFO, changed in each release
set version=15
set newver=%version%
set rawver=15
set betabuild=15A
set betabuildno=%betabuild%
set filerawver=%rawver%


:verydeeprestart
IF NOT EXIST "%MYFILES%\SuroADB" MKDIR "%MYFILES%\SuroADB"
goto makedir

:makedir
CD %MYFILES%
IF NOT "%cd%"=="%MYFILES%" goto cderror2
set wdre=%MYFILES%
set audir=%MYFILES%\SuroADB
set tempdir=%MYFILES%\sroadbtemp
IF NOT EXIST "%audir%" MKDIR "%audir%"
IF NOT EXIST "%tempdir%" MKDIR "%tempdir%"
IF NOT EXIST "%tempdir%\SuroADB" MKDIR "%tempdir%\SuroADB"
IF NOT EXIST "%tempdir%\db" MKDIR "%tempdir%\db"
IF NOT EXIST "%tempdir%\Apk" MKDIR "%tempdir%\Apk"
IF NOT EXIST "%tempdir%\Push" MKDIR "%tempdir%\Push"
IF NOT EXIST "%tempdir%\Update" MKDIR "%tempdir%\Update"
echo %TIME% %DATE% SuroADB %version% build %betabuildno% started >> "%tempdir%\SuroADB\sroadb-runtime.txt"
echo %TIME% %DATE% Directories configured >> "%tempdir%\SuroADB\sroadb-runtime.txt"
goto setconfigdefault


:setconfigdefault
:: SETTINGS CONFIGS
:: (RUNTIME)

:: counters
set entries=0
set trost=0
set sessionid=%random%
set exports=0
:: color
set diode=3f
:: logging
set logst=ON
:: custom startup
set startupcmd=menu
:: configs
set sdconfig=/sdcard
set exsdconfig=NOT_SET
:: wifi mode
set deviceip=NOT_SET

:: (PATH VARIABLES)
:: working directory
set wdre=%MYFILES%
set audir=%MYFILES%\SuroADB
set tempdir=%MYFILES%\sroadbtemp
:: for apk install
set instal=%tempdir%\Apk
:: for package list
set exportpackage=no
:: for file push and pullf
set pullf=NOT_SET
set pushf=NOT_SET
:: for screenrecord and screenshot
set scrsp=NOT_SET
set scrp=NOT_SET
set scrsi=1280x720
set scrti=180

echo %TIME% %DATE% Default settings set >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF EXIST "%audir%\srodb-settings.bat" goto setconfig
IF NOT EXIST "%audir%\srodb-settings.bat" goto setconfig


:: This applies all settings into sroadb-settings.bat
:setconfig
IF EXIST "%audir%\srodb-settings.bat" CALL "%audir%\srodb-settings.bat"
IF EXIST "%audir%\srodb-settings.bat" echo %TIME% %DATE% srodb-settings.bat called >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF NOT EXIST "%audir%\srodb-settings.bat" echo %TIME% %DATE% Default settings exported >> "%tempdir%\SuroADB\sroadb-runtime.txt"
set return=opstartup
goto setconfig0
:setconfig0
(
echo :: Last updated on %TIME% %DATE%
echo set entries=%entries%
echo set trost=%trost%
echo set sessionid=%random%
echo set diode=%diode%
echo set logst=%logst%
echo set startupcmd=%startupcmd%
echo set sdconfig=%sdconfig%
echo set exsdconfig=%exsdconfig%
echo set deviceip=%deviceip%
echo set exportpackage=%exportpackage%
echo set wdre=%wdre%
echo set audir=%audir%
echo set tempdir=%tempdir%
echo set instal=%instal%
echo set pullf=%pullf%
echo set pushf=%pushf%
echo set scrsp=%scrsp%
echo set scrp=%scrp%
set scrsi=1280x720
set scrti=180

echo exit /b
) > %audir%\srodb-settings.bat
set /A exports=%exports% + 1
echo %TIME% %DATE% Settings applied and exported (%exports%) >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF EXIST "%audir%\srodb-settings.bat" CALL "%audir%\srodb-settings.bat"
IF "%return%" == "" goto clsmenu
goto %return%
goto opstartup

:opstartup
:: (Directory setup moved to lines 30~)

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
echo %TIME% %DATE% Verinfo created for SuroADB %version% build %betabuildno% >> "%tempdir%\SuroADB\sroadb-runtime.txt"


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
IF EXIST "%audir%\srodb-settings.bat" CALL "%audir%\srodb-settings.bat"
set /A trost=%trost% + 1
echo %TIME% %DATE% %trost% sessions >> "%tempdir%\SuroADB\sroadb-runtime.txt"
set return=srocounter2
goto setconfig0
:srocounter2
IF %trost%==5 goto srocounter2
goto runtimelog


:srocounter2
color %diode%
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
IF NOT EXIST "%tempdir%\SuroADB\sroadb-runtime.txt" echo SuroADB Runtime Logs > "%tempdir%\SuroADB\sroadb-runtime.txt"

:: This will set your selected color scheme.
:colorset
title SuroADB %version% : Setting color scheme.. 
color %diode%
echo %TIME% %DATE% Color scheme changed to %diode% >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF %ERRORLEVEL%==1 set rest=cols
IF %ERRORLEVEL%==1 goto restore
goto cfgcall


:: This calls the config (path file)
:cfgcall
title SuroADB %version% : Calling config files.. 
echo %TIME% %DATE% Path configs called: values=%sdconfig%, %exsdconfig% >> "%tempdir%\SuroADB\sroadb-runtime.txt"

:: This will check for updates at start.
:updtchk
IF EXIST "%MYFILES%\updtstop.txt" echo %TIME% %DATE% updtstop.txt present, skipping update check >> "%tempdir%\SuroADB\sroadb-runtime.txt"
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
echo %TIME% %DATE% deviceip called >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF %deviceip%==NOT_SET goto credb
goto wifidebugmode0
:deldevip
:wifidebugmode0
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
 cls
 echo Wifi debug mode will not apply at start anymore to avoid errors.
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
IF EXIST "%tempdir%\SuroADB\devchk.txt" echo %TIME% %DATE% devchk.txt present, skipping adb devices check >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF EXIST "%tempdir%\SuroADB\devchk.txt" goto sdconfig
title SuroADB %version% : Starting ADB.. 
cls
echo %TIME% %DATE% adb.exe has awoketh >> "%tempdir%\SuroADB\sroadb-runtime.txt"
adb devices
cls
:: This checks the presence of SDCONFIG
:sdconfig
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" goto sdconfigver
goto stt1
:sdconfigver
IF %exsdconfig%==NOT_SET goto cfgcrr
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
IF /i %cfgcre%==OK goto sdconfigchk
goto cfgcrr3

:sdconfigchk
set sdconfig=%sdconfig%
set exsdconfig=%exsdconfig%
set return=clsmenu
goto setconfig0


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
echo %TIME% %DATE% Directories configured once again >> "%tempdir%\SuroADB\sroadb-runtime.txt"
title SuroADB %version% : Configuring log files.. 
IF EXIST "%audir%\sroadb-logs.txt" goto elog
goto logmk
:elog
IF EXIST "%audir%\sroadb-errorlog.txt" goto stt2
goto logmk
:logmk
echo %TIME% %DATE% Log files created >> "%tempdir%\SuroADB\sroadb-runtime.txt"
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
IF NOT EXIST "%tempdir%\SuroADB\devchk.txt" adb devices
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
IF EXIST "%MYFILES%\sroadb13w.txt" set localver=13
IF EXIST "%MYFILES%\sroadb13w.txt" goto oldvergen
IF EXIST "%MYFILES%\sroadb131w.txt" set localver=13.1
IF EXIST "%MYFILES%\sroadb131w.txt" goto oldvergen
IF EXIST "%MYFILES%\sroadb14w.txt" set localver=14
IF EXIST "%MYFILES%\sroadb14w.txt" goto oldvergen2
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
echo %TIME% %DATE% Version %localver% detected >> "%tempdir%\SuroADB\sroadb-runtime.txt"
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
DEL /Q "%MYFILES%\sroadb13w.txt"
DEL /Q "%MYFILES%\sroadb131w.txt"
cls
echo %TIME% %DATE% Version %localver% detected >> "%tempdir%\SuroADB\sroadb-runtime.txt"
title SuroADB %version%
echo You've been using SuroADB %localver%. Great!
echo.
echo Starting in SuroADB 14, the way SuroADB reads and saves
echo preferences and settings such as paths and switches has
echo been completely reworked, so the classic individual files having
echo their own usage in the code now relies on a single file instead!
echo.
echo Because of this, you need a clean sweep of SuroADB's data folders
echo to help delete useless files.
echo.
echo Would you like to do that now?
echo.
set /p sroc2= Y / N : 
cls
IF /i %sroc2%==Y goto srouninstall3
IF /i %sroc2%==N goto conft
goto oldvergen

:oldvergen2
DEL /Q "%MYFILES%\sroadb14w.txt"
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
goto oldvergen2


:conft
:: This automates the cd to the one you set.
:: MYFILES is the temp folder for suroadb.
:precd
title SuroADB %version% : Configuring working directories.. 
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
IF %rest%==cols echo %TIME% %DATE% color value "%diode%" has set ERRORLEVEL to 1. >> "%audir%\sroadb-errorlog.txt"
IF %rest%==cols set diode=3f
IF %rest%==cols set return=interfacemenu
IF %rest%==cols goto setconfig0
IF %rest%==betabuildstarter echo %TIME% %DATE% betabuild.bat was changed, but SuroADB!Beta.exe is missing. Please don't modify betabuild.bat! >> "%audir%\sroadb-errorlog.txt"
IF %rest%==betabuildstarter (
echo set betabuild=%betabuildno%
echo exit /b
) > "%tempdir%\SuroADB\betabuild.bat"
IF %rest%==betabuildstarter echo %TIME% %DATE% betabuild.bat restored to %betabuildno% compatibility. >> "%audir%\sroadb-errorlog.txt"
IF %rest%==betabuildstarter goto verydeeprestart
IF %rest%==customcd del /Q "%audir%\sroadbcd.bat"
IF %rest%==customcd echo %TIME% %DATE% invalid path "%sroadbcd%". >> "%audir%\sroadb-errorlog.txt"
IF %rest%==customcd goto verydeeprestart

:restore1
title SuroADB %version% build %betabuildno% : FATAL ERROR OCCURED
cls
echo An error has occured that prevented SuroADB from doing something. 
echo.
echo In an attempt to fix it, SuroADB will delete
echo.
echo %audir%
echo.
echo This will affect logs, settings, and others.
echo.
echo For more information, you may find something useful in:
echo %audir%\sroadb-errorlog.txt
echo Note: Only continue after you're done with the log files!
echo.
pause
cls
RD /S /Q "%audir%
goto verydeeprestart

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
echo %TIME% %DATE% Error while configuring working directory to %sroadbcd%. deleting sroadbcd.bat. >> "%audir%\sroadb-errorlog.txt"
DEL /Q %audir%\sroadbcd.bat
IF NOT EXIST "%audir%\sroadbcd.bat" echo %TIME% %DATE% sroadbcd.bat deleted. retrying configuration. >> "%audir%\sroadb-errorlog.txt"
cls
cd "%MYFILES%"
IF NOT "%cd%"=="%MYFILES%" echo %TIME% %DATE% unable to configure CD to "%sroadbcd%". >> "%audir%\sroadb-errorlog.txt"
IF NOT "%cd%"=="%MYFILES%" goto cderror21
IF "%cd%"=="%MYFILES%" echo %TIME% %DATE% working directory set to %MYFILES%. >> "%audir%\sroadb-errorlog.txt"
goto stt
:cderror21
echo %TIME% %DATE% unable to set cd to %MYFILES% >> "%audir%\sroadb-errorlog.txt"
set cderrorm=exit
REM CursorHide
title SuroADB %version% build %betabuildno% : Directory error.. 
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

:: For debugging and testing
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
IF NOT EXIST "%wdre%" echo %TIME% %DATE% %wdre% does not exist! >> "%audir%\sroadb-errorlog.txt"
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
echo %TIME% %DATE% betabuild.bat created >> "%tempdir%\SuroADB\sroadb-runtime.txt"
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" goto premenu
echo SuroADB %version% build %betabuildno% installed as %MYFILES% on %TIME% %DATE%  > "sroadb%filerawver%w.txt"
echo %TIME% %DATE% SuroADB has been installed via %MYFILES% >> "%tempdir%\SuroADB\sroadb-runtime.txt"
goto verify



:: This verifies that the extraction of embedded ADB files have been
:: successful. This only needs to run once.
:verify
title SuroADB %version% : Verifying files.. 
cls
IF NOT EXIST "%MYFILES%\adb.exe" goto v2f
IF NOT EXIST "%MYFILES%\AdbWinApi.dll" goto v2f
IF NOT EXIST "%MYFILES%\AdbWinUsbApi.dll" goto v2f
IF NOT EXIST "%MYFILES%\fastboot.exe" goto v2f
IF NOT EXIST "%MYFILES%\download.exe" goto v2f
cls
goto wlcm2

:v2f
echo %TIME% %DATE% Incomplete files, or extraction error >> "%audir%\sroadb-errorlog.txt"
title SuroADB %version% build %betabuildno% : File error.. 
cls
echo One or more files have not been extracted succesfully.
echo Please try to start SuroADB.exe again.
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
IF NOT %exsdconfig%==NOT_SET goto wlcm21
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
IF /i %cfgcre%==OK goto sdconfigver2
goto wlcver4

:sdconfigver2
set sdconfig=%sdconfig%
set exsdconfig=%exsdconfig%
set return=clsmenu
goto setconfig0


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
IF /i %cfgcre%==OK goto sdconfigver3
goto wlcnotice2

:sdconfigver3
set sdconfig=%sdconfig%
set exsdconfig=%exsdconfig%
set return=adminnotice
goto setconfig0


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

:: This is the startup mechanism for the cmd startup configuration
:: Variables are set from srodb-settings.bat
:premenu
IF /i %startupcmd%==menu goto clsmenu
IF /i %startupcmd%==devices goto op1
IF /i %startupcmd%==install goto op2
IF /i %startupcmd%==uninstall goto op3
IF /i %startupcmd%==packages goto op4
IF /i %startupcmd%==pull goto op5
IF /i %startupcmd%==push goto op6
IF /i %startupcmd%==screenshot goto op51
IF /i %startupcmd%==screenrecord goto op52
IF /i %startupcmd%==poweroff goto op7
IF /i %startupcmd%==reboot goto op8
IF /i %startupcmd%==adb goto sandbox1
IF /i %startupcmd%==shell goto shellmode
IF /i %startupcmd%==wifi goto wirels
goto clsmenu


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

:: SH FOR INSTALL
IF /i %main%==apk goto apkinstallH
IF /i %main%==apks goto apkinstallS
IF /i %main%==apkr goto apkinstallR
IF /i %main%==apkg goto apkinstallG
:: SH for PUSH
IF /i %main%==folder goto pushf2
IF /i %main%==file goto pushf3
:: SH for SCREENSHOT
IF /i %main%==sc goto scsh
:: SH for POWER
IF /i %main%==system goto op81
IF /i %main%==recovery goto recv
IF /i %main%==bootloader goto btld

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

:: SH FOR INSTALL
IF /i %main%==apk goto apkinstallH
IF /i %main%==apks goto apkinstallS
IF /i %main%==apkr goto apkinstallR
IF /i %main%==apkg goto apkinstallG
:: SH for PUSH
IF /i %main%==folder goto pushf2
IF /i %main%==file goto pushf3
:: SH for SCREENSHOT
IF /i %main%==sc goto scsh
:: SH for POWER
IF /i %main%==system goto op81
IF /i %main%==recovery goto recv
IF /i %main%==bootloader goto btld


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
IF /i %wirepr%==Y goto wirels2
IF /i %wirepr%==N goto clsmenu
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% "%result%" selected for install to device. >> %audir%\sroadb-logs.txt
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% "%result%" selected for install to device. >> %audir%\sroadb-logs.txt
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% "%result%" selected for install to device. >> %audir%\sroadb-logs.txt
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% "%result%" selected for install to device. >> "%audir%\sroadb-logs.txt"
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
echo.
echo.
set /p unpackage= : 
cls
if %unpackage%==menu goto clsmenu
if %unpackage%==MENU goto clsmenu
adb uninstall %unpackage%
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% "%unpackage%" selected for uninstallation. >> "%audir%\sroadb-logs.txt"
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
IF /i %opno%==Y goto epkg
IF /i %opno%==N goto clsmenu
goto clsmenu
:epkg
ping localhost -n 2 >nul
cls
set exportpackage=yes
set return=clsmenu
goto setconfig0

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
IF /i %pullf%==MENU goto clsmenu
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% "%pullf%" copied to "%result%". >> %audir%\sroadb-logs.txt
echo.
goto op5c


:: FILE PUSH

:op6
IF EXIST "%wdre%\sroadbtemp\Push" RD /S /Q "%wdre%\sroadbtemp\Push"
IF NOT EXIST "%wdre%\sroadbtemp\Push" MKDIR "%wdre%\sroadbtemp\Push"
cls
goto op61

:op61
set pushf=NO FILE/FOLDER SELECTED
echo What do you want to copy to your device?
echo.
set /p pushf1= folder / file / menu : 
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

:: FOLDER PUSH
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% "%result%" copied to "%pushf%". >> "%audir%\sroadb-logs.txt"
echo.
goto op61

:: New experimental file push handler that supports spaces! (BROKEN !)
:: file copies to temp folder (even with spaces) but it cant copy in adb.

:pushf3
cls
set pushff1=file
echo Select the file
:pushf33
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

:pushpath
set puspath=%~dp1

cls

:pushf3prep
set pushfvar=%result%
echo Copying file to a temp folder.. This helps detect errors..
COPY /Y "%result%" "%wdre%\sroadbtemp\Push" >nul
IF EXIST "%wdre%\sroadbtemp\Push\%pusname%" goto pushnative2
ping localhost -n 3 >nul
echo File name error has been found, switching to workaround..
COPY /Y "%puspath%%pusname%" "%wdre%\sroadbtemp\Push" >nul
IF NOT EXIST "%wdre%\sroadbtemp\Push\%pusname%" goto puserror0
ping localhost -n 3 >nul
goto pushnative404

:: New file push handler's file push executer

:pushnative2
cls
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
ping localhost -n 2 >nul
IF EXIST "%tempdir%\Push" RD /S /Q "%tempdir%\Push"
IF NOT EXIST "%tempdir%\Push" MKDIR "%tempdir%\Push"
IF %logst%==ON echo %TIME% %DATE% "%pusname%" copied to "%pushf%". >> "%audir%\sroadb-logs.txt"
echo.
goto op61

:: File Push workaround.
:pushnative404
cls
echo A folder named "Push" will be copied to the path
echo you enter.
echo.
echo This folder will contain "%pusname%".
echo.
echo Enter the path to where the folder should go.
echo ex. %sdconfig%
echo.
echo to cancel operation, enter MENU
echo.
set /p pushf= :
cls
IF /i %pushf%==MENU RD /S /Q "%tempdir%\Push"
IF /i %pushf%==MENU goto clsmenu
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
ping localhost -n 2 >nul
cls
echo Copying : %tempdir%\Push (contains %pusname%)
echo To : %pushf%
adb push "%tempdir%\Push" "%pushf%"
IF %logst%==ON echo %TIME% %DATE% "%pusname%" copied to "%pushf%/Push" via Workaround. >> "%audir%\sroadb-logs.txt"
IF EXIST "%tempdir%\Push" RD /S /Q "%tempdir%\Push"
IF NOT EXIST "%tempdir%\Push" MKDIR "%tempdir%\Push"
goto op61

:puserror
(
echo %TIME% %DATE% file push error
echo ==data==
echo File: %pusname%
echo Destination: %pushf%
echo Source: %result%
echo ==end==
) >> "%audir%\sroadb-errorlog.txt"
:puserrorui
cls
echo Error while copying the file to a temp folder.
echo.
echo This could be caused by a file name error. Would you like to try
echo the workaround?
echo.
echo.
set /p puserror1= Y / N : 
cls
IF /i %puserror1%==Y goto pushf3prep
IF /i %puserror1%==N RD /S /Q "%wdre%\sroadbtemp\Push"
IF /i %puserror1%==N goto op6
goto puserrorui

:puserror0
(
echo %TIME% %DATE% unknown file push error
echo ==data==
echo File: %pusname%
echo Destination: %pushf%
echo Source: %result%
echo ==end==
) >> "%audir%\sroadb-errorlog.txt"
cls
echo Error while copying file to a temp folder.
echo.
echo Please rename your file to something
echo that does not contain spaces, then try again.
echo.
echo Information has been logged to:
echo %audir%\sroadb-errorlog.txt
echo.
goto op61




:: FILE PUSH END

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
IF /i %screen%==MENU goto clsmenu
goto op51path

:op51path
IF NOT %scrsp%==NOT_SET goto scrsp1
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% screenshot "%screen%" saved to "%scrsp%". >> "%audir%\sroadb-logs.txt"
:scrp2
IF NOT %scrsp%==NOT_SET goto goto scrsps
cls
echo Would you like to set %scrsp% as a default save path for screenshots from now on?
echo.
set /p scrsv=Y / N : 
cls
IF /i %scrsv%==Y goto scrspp
IF /i %scrsv%==N goto scrsps
goto scrp2

:scsh
set scrsp=/sdcard
set screen=adbscreenshot-%random%-%sessionid%.png
adb shell screencap "/sdcard/%screen%"
goto scrp2

:scrspp
set scrsp=%scrsp%
set return=scrsps
goto setconfig0

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
cls
echo Device Screen Recording (size: %scrsi% time: %scrti% seconds)
echo.
echo Would you like to set up output resolution and time limit?
echo.
echo  Y - set up
echo  N - use current settings
echo  X - go back to main menu
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
echo Device Screen Recording 1/3 (size: %scrsi% time: %scrti% seconds)
echo.
echo Set the desired recording resolution. ex. 1280x720 (default)
echo leave empty to continue with current resolution.
echo.
echo.
set /p scrsi= : 
cls
goto scrmys2

:scrmys2
cls
echo Device Screen Recording 2/3 (size: %scrsi% time: %scrti% seconds)
echo.
echo Set how many seconds to record. Maximum is 180 seconds (maximum and default)
echo leave empty to continue with %scrti% seconds.
echo.
echo.
set /p scrti= : 
cls
echo.
goto scrrdy

:scrrdy
cls
echo Device Screen recording
echo.
echo Resolution: %scrsi% Time: %scrti% seconds.
echo Is this okay?
echo.
echo  Y - continue
echo  N - start setup again
echo  X - go back to main menu
echo.
echo.
set /p scrmyy= Y / N : 
cls
IF /i %scrmyy%==Y goto scrrdyset
IF /i %scrmyy%==N goto scrmy
IF /i %scrmyy%==X goto clsmenu
goto scrrdy

:scrrdyset
set scrsi=%scrsi%
set scrti=%scrti%
set return=op522
goto setconfig0

:op522
cls
echo Begin screen recording? (size: %scrsi% time: %scrti% seconds.)
echo.
echo  Y - begin
echo  S - configure settings
echo  X - go back to main menu
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
cls
echo Enter desired filename. ex. record.mp4
echo (avoid spaces and include .mp4!)
echo.
set /p scrbegin2= : 
cls
goto scrbegin11

:scrbegin11
IF EXIST "%audir%\sroadbsrpath.bat" goto scrp3
echo  Enter the path to where the file should go.
echo  ex. %sdconfig%/videos
echo.
set /p scrp= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
goto scrp22

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
set scrsp=%scrp%
set return=%scrp3%
goto setconfig0

:scrp3
cls
echo Recording %scrti% seconds. File will be saved to "%scrp%"
adb shell screenrecord --size %scrsi% --time-limit %scrti% "%scrp%"/%scrbegin2%
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% screen recording "%scrbegin2%" saved to "%scrsp%". >> "%audir%\sroadb-logs.txt"
:scrp31
cls
echo Success. Would you like to copy %scrbegin2% to your computer?
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% "%scrsp%/%scrbegin2%" copied to "%result%". >> "%audir%\sroadb-logs.txt"
echo.
goto op52

:opsy
cls
echo Select the destination path.
rem BrowseFolder
IF %result%==0 set opcode=Screenshot file push destination.
IF %result%==0 goto opcancel
adb pull %scrsp%/%screen% "%result%"
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% "%scrsp%/%screen%" copied to "%result%". >> "%audir%\sroadb-logs.txt"
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% device shutdown. >> "%audir%\sroadb-logs.txt"
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
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% device reboot. >> "%audir%\sroadb-logs.txt"
ping localhost -n 3 >nul
echo Success.
echo.
goto menu

:recv
cls
echo Rebooting to Recovery...
ping localhost -n 3 >nul
adb shell reboot recovery
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% device reboot to recovery. >> "%audir%\sroadb-logs.txt"
ping localhost -n 3 >nul
echo Success.
echo.
goto menu

:btld
cls
echo Rebooting to Bootloader...
ping localhost -n 3 >nul
adb shell reboot bootloader
IF %logst%==ON set /A entries=%entries% + 1
IF %logst%==ON echo %TIME% %DATE% device reboot to bootloader. >> "%audir%\sroadb-logs.txt"
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

:: SH FOR INSTALL
IF /i %helpnemu%==apk goto apkinstallH
IF /i %helpnemu%==apks goto apkinstallS
IF /i %helpnemu%==apkr goto apkinstallR
IF /i %helpnemu%==apkg goto apkinstallG
:: SH for PUSH
IF /i %helpnemu%==folder goto pushf2
IF /i %helpnemu%==file goto pushf3
:: SH for SCREENSHOT
IF /i %helpnemu%==sc goto scsh
:: SH for POWER
IF /i %helpnemu%==system goto op81
IF /i %helpnemu%==recovery goto recv
IF /i %helpnemu%==bootloader goto btld

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
IF EXIST "%tempdir%\SuroADB\rlogdel.txt" goto exitp2
exit

:exitp2
echo Deleting runtime log..
IF EXIST "%tempdir%\SuroADB\sroadb-runtime.txt" DEL /Q "%tempdir%\SuroADB\sroadb-runtime.txt"
cls
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
echo    def (change things to default) (broken)
echo    config (sdcard directories)
echo    update
echo    logs (set logging on/off, view all logs)
echo    temp (open the temp/default working directory folder)
echo    troubleshoot
echo    debug
echo    info
echo    readme
echo.
echo    runtime
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
IF /i %srodb%==runtime goto runtimesettings

:: SH FOR INSTALL
IF /i %srodb%==apk goto apkinstallH
IF /i %srodb%==apks goto apkinstallS
IF /i %srodb%==apkr goto apkinstallR
IF /i %srodb%==apkg goto apkinstallG
:: SH for PUSH
IF /i %srodb%==folder goto pushf2
IF /i %srodb%==file goto pushf3
:: SH for SCREENSHOT
IF /i %srodb%==sc goto scsh
:: SH for POWER
IF /i %srodb%==system goto op81
IF /i %srodb%==recovery goto recv
IF /i %srodb%==bootloader goto btld

goto suroadbm

:csuroadbm
cls
echo SuroADB Settings
echo.
echo    UI Settings:
echo    color : ui
echo.
echo    Defaults, Directories, and Logging:
echo    def (broken) : config : temp : logs
echo.
echo    Updates and Troubleshooting:
echo    update : troubleshoot : debug
echo.
echo    Readables:
echo    info : readme
echo.
echo    Uninstall and Runtime:
echo    uninstall : runtime
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
IF /i %srodb%==runtime goto runtimesettings

:: SH FOR INSTALL
IF /i %srodb%==apk goto apkinstallH
IF /i %srodb%==apks goto apkinstallS
IF /i %srodb%==apkr goto apkinstallR
IF /i %srodb%==apkg goto apkinstallG
:: SH for PUSH
IF /i %srodb%==folder goto pushf2
IF /i %srodb%==file goto pushf3
:: SH for SCREENSHOT
IF /i %srodb%==sc goto scsh
:: SH for POWER
IF /i %srodb%==system goto op81
IF /i %srodb%==recovery goto recv
IF /i %srodb%==bootloader goto btld

goto suroadbm


:runtimesettings
IF NOT EXIST "%tempdir%\SuroADB\devchk.txt" set devstatus=DISABLE
IF EXIST "%tempdir%\SuroADB\devchk.txt" set devstatus=ENABLE
IF NOT EXIST "%tempdir%\SuroADB\rlogdel.txt" set rlogstatus=ENABLE
IF EXIST "%tempdir%\SuroADB\rlogdel.txt" set rlogstatus=DISABLE
IF NOT EXIST "%tempdir%\SuroADB\sroadbstt.bat" (
echo set startupcmd=menu (default)
echo exit /b
) > "%tempdir%\SuroADB\sroadbstt.bat"
IF EXIST "%tempdir%\SuroADB\sroadbstt.bat" call "%tempdir%\SuroADB\sroadbstt.bat"
cls
echo SuroADB Runtime\Startup settings
echo.
echo  Note: Enabling or disabling these settings may improve
echo  startup time at the cost of slower operations on first run
echo.
echo   sta - Configure what command to start on startup (%startupcmd%)
echo.
echo   dev - %devstatus% runtime adb devices check
echo   rlog - %rlogstatus% deletion of runtime-logs.txt on exit
echo.
echo menu
echo.
set /p runtimeset= : 
cls
IF /i %runtimeset%==dev goto devchecksw
IF /i %runtimeset%==rlog goto rlogsw
IF /i %runtimeset%==sta goto staconf
IF /i %runtimeset%==menu goto suroadbm
goto runtimesettings

:staconf
IF EXIST "%tempdir%\SuroADB\sroadbstt.bat" call "%tempdir%\SuroADB\sroadbstt.bat"
cls
echo Configure what command SuroADB will start by default
echo.
echo Currently starting : %startupcmd%
echo.
echo   menu : devices : install : uninstall : packages
echo   pull : push : screenshot : screenrecord
echo.
echo   poweroff : reboot
echo.
echo   adb : shell : wifi
echo.
echo   back (return to menu)
echo.
set /p stacmd= : 
cls
IF /i %stacmd%==menu goto staconf2
IF /i %stacmd%==devices goto staconf2
IF /i %stacmd%==install goto staconf2
IF /i %stacmd%==uninstall goto staconf2
IF /i %stacmd%==packages goto staconf2
IF /i %stacmd%==pull goto staconf2
IF /i %stacmd%==push goto staconf2
IF /i %stacmd%==screenshot goto staconf2
IF /i %stacmd%==screenrecord goto staconf2
IF /i %stacmd%==poweroff goto staconf2
IF /i %stacmd%==reboot goto staconf2
IF /i %stacmd%==adb goto staconf2
IF /i %stacmd%==shell goto staconf2
IF /i %stacmd%==wifi goto staconf2
IF /i %stacmd%==back goto runtimesettings
goto staconf

:staconf2
set startupcmd=%stacmd%
set return=staconf
goto setconfig0



:devchecksw
IF %devstatus%==ENABLE DEL /Q "%tempdir%\SuroADB\devchk.txt"
IF %devstatus%==DISABLE echo this will disable adb devices check on runtime > "%tempdir%\SuroADB\devchk.txt"
goto runtimesettings
:rlogsw
IF %rlogstatus%==ENABLE echo this will delete the runtime log on exit > "%tempdir%\SuroADB\rlogdel.txt"
IF %rlogstatus%==DISABLE DEL /Q "%tempdir%\SuroADB\rlogdel.txt"
goto runtimesettings




:uisettings
set menuui=UNKNOWN_ERROR
IF NOT EXIST "%audir%\sroadbuic.txt" set menuui=COMPACT
IF EXIST "%audir%\sroadbuic.txt" set menuui=ORIGINAL
set sroui=mu
cls
echo SuroADB UI
echo.
echo  Press ENTER to switch UI to %menuui% mode.
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
cls
goto uisettings
:compsw
echo compact > "%audir%\sroadbuic.txt"
cls
goto suroadbm
:origsw
DEL /Q "%audir%\sroadbuic.txt"
cls
goto suroadbm

:srouninstall
cls
echo Would you like to delete all SuroADB files and data?
echo.
echo Be noted that the pre-compiled files will be extracted again if
echo SuroADB.exe is started.
echo.
echo.
set /p unprompt= Y / N : 
cls
IF /i %unprompt%==Y goto srouninstall2
IF /i %unprompt%==N goto suroadbm
goto srouninstall
:srouninstall2
cls
echo Are you sure? All data and preferences will be deleted!
echo.
echo.
set /p unpromptq= Y / N : 
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
echo A5 Closing SuroADB.exe (SuroADB process)
taskkill /F /IM SuroADB.exe
echo A5 Closing SuroADB.exe (2)
taskkill /F /IM SuroADB.exe
ping localhost -n 3 >nul
echo B1 Deleting adb resources
DEL /Q "%MYFILES%\adb.exe"
DEL /Q "%MYFILES%\AdbWinApi.dll"
DEL /Q "%MYFILES%\AdbWinUsbApi.dll"
DEL /Q "%MYFILES%\download.exe"
DEL /Q "%MYFILES%\fastboot.exe"
echo B1.1 Deleting old adb resources
IF EXIST "%MYFILES%\dmtracedump.exe" DEL /Q "%MYFILES%\dmtracedump.exe"
IF EXIST "%MYFILES%\etc1tool.exe" DEL /Q "%MYFILES%\etc1tool.exe"
IF EXIST "%MYFILES%\hprof-conv.exe" DEL /Q "%MYFILES%\hprof-conv.exe"
IF EXIST "%MYFILES%\libwinpthread-1.dll" DEL /Q "%MYFILES%\libwinpthread-1.dll"
IF EXIST "%MYFILES%\make_f2fs.exe" DEL /Q "%MYFILES%\make_f2fs.exe"
IF EXIST "%MYFILES%\mke2fs.conf" DEL /Q "%MYFILES%\mke2fs.conf"
IF EXIST "%MYFILES%\mke2fs.exe" DEL /Q "%MYFILES%\mke2fs.exe"
IF EXIST "%MYFILES%\source.properties" DEL /Q "%MYFILES%\source.properties"
IF EXIST "%MYFILES%\sqlite3.exe" DEL /Q "%MYFILES%\sqlite3.exe"
echo B2 Deleting SuroADB resources
DEL /Q "%MYFILES%\sroadb%filerawver%w.txt"
DEL /Q "%MYFILES%\sroadbupdate.exe"
DEL /Q "%MYFILES%\sroadbupdateui.bat"
DEL /Q "%MYFILES%\readme-help.txt"
DEL /Q "%MYFILES%\sroadbbetaui.bat"
IF EXIST "%MYFILES%\SuroADB!Beta.exe" DEL /Q "%MYFILES%\SuroADB!Beta.exe"
echo B3 Deleting external SuroADB data
IF EXIST "%MYFILES%\updtstop.txt" DEL /Q "%MYFILES%\updtstop.txt"
IF EXIST "%MYFILES%\updatechk.bat" DEL /Q "%MYFILES%\updatechk.bat"
IF EXIST "%MYFILES%\sroadb-debug.txt" DEL /Q "%MYFILES%\sroadb-debug.txt"
IF EXIST "%MYFILES%\sroadb-errorlog.txt" DEL /Q "%MYFILES%\sroadb-errorlog.txt"
IF EXIST "%MYFILES%\sroadbdb.bat" DEL /Q "%MYFILES%\sroadbdb.bat"
IF EXIST "%MYFILES%\sroadbverinfo.bat" DEL /Q "%MYFILES%\sroadbverinfo.bat"
echo C1 Deleting temp data folder
RD /S /Q "%tempdir%"
echo C2 Deleting SuroADB settings and log file folder
RD /S /Q "%audir%"
:uver1
echo D1 Checking
IF EXIST "%MYFILES%\adb.exe" goto unerror
IF EXIST "%MYFILES%\AdbWinApi.dll" goto unerror
IF EXIST "%MYFILES%\AdbWinUsbApi.dll" goto unerror
IF EXIST "%MYFILES%\download.exe" goto unerror
IF EXIST "%MYFILES%\fastboot.exe" goto unerror
IF EXIST "%MYFILES%\dmtracedump.exe" goto unerror
IF EXIST "%MYFILES%\etc1tool.exe" goto unerror
IF EXIST "%MYFILES%\hprof-conv.exe" goto unerror
IF EXIST "%MYFILES%\libwinpthread-1.dll" goto unerror
IF EXIST "%MYFILES%\make_f2fs.exe" goto unerror
IF EXIST "%MYFILES%\mke2fs.conf" goto unerror
IF EXIST "%MYFILES%\mke2fs.exe" goto unerror
IF EXIST "%MYFILES%\source.properties" goto unerror
IF EXIST "%MYFILES%\sqlite3.exe" DEL /Q goto unerror
IF EXIST "%MYFILES%\sroadb%filerawver%w.txt" goto unerror
IF EXIST "%MYFILES%\sroadbupdate.exe" goto unerror
IF EXIST "%MYFILES%\sroadbupdateui.bat" goto unerror
IF EXIST "%MYFILES%\readme-help.txt" goto unerror
IF EXIST "%MYFILES%\updtstop.txt" goto unerror
IF EXIST "%MYFILES%\updatechk.bat" goto unerror
IF EXIST "%MYFILES%\sroadbdb.bat" goto unerror
IF EXIST "%MYFILES%\sroadb-debug.txt" goto unerror
IF EXIST "%MYFILES%\sroadb-errorlog.txt" goto unerror
IF EXIST "%MYFILES%\sroadbbetaui.bat" goto unerror
IF EXIST "%MYFILES%\SuroADB!Beta.exe" goto unerror
IF EXIST "%MYFILES%\sroadbverinfo.bat" goto unerror
IF EXIST "%tempdir%" goto unerror
IF EXIST "%audir%" goto unerror
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
echo Delete remaining files manually, or retry the uninstall process.
IF EXIST "%MYFILES%\SuroADB!Beta.exe" echo To delete SuroADB!Beta, exit SuroADB first.
echo.
start "%SystemRoot%\explorer.exe" "%MYFILES%"
pause
exit

:trouble
set troubles=cd
cls
:troble2
echo What should be fixed?
echo.
echo  CD : 'adb is not recognized as an internal command'
echo  XX  : revert to default working directory
echo.
echo  X  : return to menu
set /p troubles= : 
cls
IF /i %troubles%==CD goto repathq
IF /i %troubles%==XX goto cdef
IF /i %troubles%==X goto suroadbm
goto trouble

:cdef
cls
cd "%MYFILES%"
echo Working directory set to %MYFILES%
DEL /Q "%audir%\sroadbcd.bat"
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


:cfgset
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
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat

set sdconfig=%sdconfig%
set return=cfgset
goto setconfig0

:excfg
cls
echo Enter the path to your EXTERNAL storage. (ex. /storage/sdcard0)
echo.
echo Please do not enclose it with a slash ( / ) at the end.
echo.
set /p exsdconfig= : 
cls
IF EXIST "%tempdir%\db\sroadbdb.bat" call "%tempdir%\db\sroadbdb.bat"
set exsdconfig=%exsdconfig%
set return=cfgset
goto setconfig0


:debugm
cls
echo SuroADB will run adb devices, then export results to:
echo %wdre%\sroadb-debug.txt
echo.
echo Before continuing, please make sure your device is ready for ADB usage.
echo.
set /p debugp=Y / X : 
IF /i %debugp%==Y goto debugm1
IF /i %debugp%==X goto suroadbm
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
echo SuroADB %version% %betabuildno% > "%tempdir%\SuroADB-DEBUG\sroadbdebugtest.txt"
adb devices
adb push "%tempdir%\SuroADB-DEBUG\sroadbdebugtest.txt" "/sdcard"
cls
(
echo SuroADB %version% build %betabuildno% DEBUG
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
IF %logst%==ON goto logno
IF %logst%==OFF goto logyes
set logst=ERROR_UNABLE_TO_SET_VARIABLES
goto logg

:logno
set logst=OFF
set return=logg
goto setconfig0

:logyes
set logst=ON
set return=logg
goto setconfig0


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
IF EXIST "%tempdir%\SuroADB\devchk.txt" echo dev - Runtime adb devices check
IF EXIST "%tempdir%\SuroADB\rlogdel.txt" echo rlog - Runtime log deletion on exit

echo all - Set everything as default
echo.
echo.
echo menu
echo.
set /p def11= : 
IF /i %def11%==sv DEL /Q "%MYFILES%\sroadb%filerawver%w.txt"
IF /i %def11%==sw DEL /Q "%audir%\sroadbcd.bat"
IF /i %def11%==log set logst=ON
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
IF /i %def11%==dev DEL /Q "%tempdir%\SuroADB\devchk.txt"
IF /i %def11%==rlog DEL /Q "%tempdir%\SuroADB\rlogdel.txt"
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
IF EXIST "%audir%\sroadblogs.bat" set logst=ON
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
IF EXIST "%audir%\sroadbexsdconfig.bat" DEL /Q "%audir%\sroadbexsdconfig.bat
IF EXIST "%tempdir%\SuroADB\devchk.txt" echo Runtime adb devices check enabled
IF EXIST "%tempdir%\SuroADB\devchk.txt" DEL /Q "%tempdir%\SuroADB\devchk.txt"
IF EXIST "%tempdir%\SuroADB\rlogdel.txt" echo Runtime log deletion disabled
IF EXIST "%tempdir%\SuroADB\rlogdel.txt" DEL /Q "%tempdir%\SuroADB\rlogdel.txt"
IF /i %def11%==dev DEL /Q "%tempdir%\SuroADB\devchk.txt"
IF /i %def11%==rlog DEL /Q "%tempdir%\SuroADB\rlogdel.txt"
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
set diode=%diodeset%
color %diode%
IF %ERRORLEVEL%==1 set rest=cols
IF %ERRORLEVEL%==1 goto restore
set return=interfacemenu
goto setconfig0


:updt
IF EXIST "%wdre%\updtstop.txt" set updtst=ON (Currently OFF)
IF NOT EXIST "%wdre%\updtstop.txt" set updtst=OFF (Currently ON)
cls
:updt1
echo Update checking
echo.
echo This will check if an update exceeding SuroADB %version% build %betabuildno% is available.
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
echo %TIME% %DATE% Unable to identify integrity of required files for updtswitch (cannot detect). >> "%audir%\sroadb-errorlog.txt"
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

:: Some more personal stuff

:faq
cls
echo.
echo    Thank you for using SuroADB! =D
echo.
echo.
echo    You are using version %version% Build %betabuild%
echo    You have used SuroADB %trost% times so far.
echo.
echo    SuroADB website : suroadb.jimdofree.com
echo    My projects : kutsuro.simdif.com
echo.
echo    2018-2019 Matt "Kutsuro" Rentaro
echo.
echo    Need help with SuroADB? contact me via hsudoru@gmail.com
echo.
pause
cls
goto suroadbm