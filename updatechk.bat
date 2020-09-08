set newver=Lite
set rawver=151
set betabuild=15A
set linea===========================================================
set lineb=ANNOUNCEMENT:
set linec= SuroADB (Legacy) development has now officially ended.
set lined= You may check out the new LITE version of SuroADB which
set linee= is basically SuroADB- but with a cleaner GUI and code!
set linef===========================================================
set lineg=timeout /T 5 /NOBREAK
set lineh=start https://bit.ly/2Fa1RAB
set linei=cls
set linej=exit
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
IF %rawver%==14 set ov=1
IF %rawver%==141 set ov=1

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
IF %betabuild%==131B set bv=1
IF %betabuild%==14A set bv=1
IF %betabuild%==141C set bv=1

exit /b