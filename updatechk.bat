 set newver=13
set rawver=13
set betabuild=13E
set linea===========================================================
set lineb=Notes:
set linec= - Reverted platform-tools to that of SuroADB 11.1 due to issues
set lined= - Added options for runtime in settings (ex. disable adb devices check, etc)
set linee= - removed some adb dependencies as they're not dependencies at all
set linef= - minor improvements to file push ui
set lineg=echo more info: bit.ly/suroadbreleasenotes
set lineh=echo ==========================================================
set linei=
set linej=
call "%USERPROFILE%AppData\Local\Temp\afolder\sroadbverinfo.bat"
IF %rawver%==70 set ov=1
IF %rawver%==71 set ov=1
IF %rawver%==80 set ov=1
IF %rawver%==81 set ov=1
IF %rawver%==90 set ov=1
IF %rawver%==91 set ov=1
IF %rawver%==10 set ov=1
IF %rawver%==101 set ov=1
IF %rawver%==11 set ov=1
IF %rawver%==111 set ov=1
IF %rawver%==12 set ov=1
IF %rawver%==121 set ov=1
IF %rawver%==13 set ov=1
exit /b
