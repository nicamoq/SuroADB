set newver=13.1
set rawver=131
set betabuild=131B
set linea===========================================================
set lineb=Notes:
set linec= - added a workaround for file push filename error
set lined=   - can detect if file has spaces
set linee= - minor adjustments for settings and screenrecord ui
set linef= - fixed and improved error logging
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
IF %rawver%==131 set ov=1
IF %betabuild%==121A set bv=1
IF %betabuild%==121B set bv=1
IF %betabuild%==121C set bv=1
IF %betabuild%==121D set bv=1
IF %betabuild%==121E set bv=1
IF %betabuild%==13A set bv=1
IF %betabuild%==13B set bv=1
IF %betabuild%==13C set bv=1
IF %betabuild%==13D set bv=1
IF %betabuild%==13E set bv=1
IF %betabuild%==131A set bv=1
exit /b
