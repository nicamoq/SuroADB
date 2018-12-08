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
IF NOT %rawver%==70 set ov=1
IF NOT %rawver%==71 set ov=1
IF NOT %rawver%==80 set ov=1
IF NOT %rawver%==81 set ov=1
IF NOT %rawver%==90 set ov=1
IF NOT %rawver%==91 set ov=1
IF NOT %rawver%==10 set ov=1
IF NOT %rawver%==101 set ov=1
IF NOT %rawver%==11 set ov=1
IF NOT %rawver%==111 set ov=1
IF NOT %rawver%==12 set ov=1
IF NOT %rawver%==121 set ov=1
IF NOT %rawver%==13 set ov=1
exit /b
