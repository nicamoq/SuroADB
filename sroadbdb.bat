@echo off

:: SDCONFIG
:insd
IF /i %sdconfig%==/sdcard/ set sdconfig=/sdcard
IF /i %sdconfig%==\sdcard\ set sdconfig=/sdcard
IF /i %sdconfig%==sdcard\ set sdconfig=/sdcard
IF /i %sdconfig%==\sdcard set sdconfig=/sdcard
IF /i %sdconfig%==sdcard set sdconfig=/sdcard
IF /i %sdconfig%==sdcard/ set sdconfig=/sdcard
IF /i %sdconfig%==/internal/ set sdconfig=/internal
IF /i %sdconfig%==internal set sdconfig=/internal
IF /i %sdconfig%==/internalsd/ set sdconfig=/internalsd
:exsd
IF /i %exsdconfig%==sdcard0 set exsdconfig=/storage/sdcard0
IF /i %exsdconfig%==/sdcard0 set exsdconfig=/storage/sdcard0
IF /i %exsdconfig%==/storage/sdcard0/ set exsdconfig=/storage/sdcard0
IF /i %exsdconfig%==/storage/ set exsdconfig=/storage
IF /i %exsdconfig%==/sdcard0/ set exsdconfig=/storage/sdcard0
IF /i %exsdconfig%==sdcard0/ set exsdconfig=/storage/sdcard0
IF /i %exsdconfig%==\sdcard0\ set exsdconfig=/storage/sdcard0
IF /i %exsdconfig%==sdcard0\ set exsdconfig=/storage/sdcard0
IF /i %exsdconfig%==/9016-4EF8/ set exsdconfig=/storage/9016-4EF8
IF /i %exsdconfig%==/9016-4EF8 set exsdconfig=/storage/9016-4EF8
IF /i %exsdconfig%==9016-4EF8/ set exsdconfig=/storage/9016-4EF8
IF /i %exsdconfig%==\9016-4EF8 set exsdconfig=/storage/9016-4EF8
IF /i %exsdconfig%==9016-4EF8\ set exsdconfig=/storage/9016-4EF8
IF /i %exsdconfig%==/9016-4EF8\ set exsdconfig=/storage/9016-4EF8
IF /i %exsdconfig%==/storage/9016-4EF8/ set exsdconfig=/storage/9016-4EF8

:: FILEPULL OP5
:fpullin
IF /i %pullf%==/sdcard/ set pullf=/sdcard
IF /i %pullf%==\sdcard\ set pullf=/sdcard
IF /i %pullf%==sdcard\ set pullf=/sdcard
IF /i %pullf%==\sdcard set pullf=/sdcard
IF /i %pullf%==sdcard set pullf=/sdcard
IF /i %pullf%==sdcard/ set pullf=/sdcard
IF /i %pullf%==/internal/ set pullf=/internal
IF /i %pullf%==internal set pullf=/internal
IF /i %pullf%==/internalsd/ set pullf=/internalsd
IF /i %pullf%==/sdcard/pictures/ set pullf=/sdcard/pictures
IF /i %pullf%==sdcard/pictures/ set pullf=/sdcard/pictures
IF /i %pullf%==/sdcard/videos/ set pullf=/sdcard/videos
IF /i %pullf%==sdcard/videos/ set pullf=/sdcard/videos
IF /i %pullf%==/sdcard/files/ set pullf=/sdcard/files
IF /i %pullf%==sdcard/files/ set pullf=/sdcard/files
:fpullsd
IF /i %pullf%==sdcard0 set pullf=/storage/sdcard0
IF /i %pullf%==/sdcard0 set pullf=/storage/sdcard0
IF /i %pullf%==/storage/sdcard0/ set pullf=/storage/sdcard0
IF /i %pullf%==/storage/ set pullf=/storage
IF /i %pullf%==/sdcard0/ set pullf=/storage/sdcard0
IF /i %pullf%==sdcard0/ set pullf=/storage/sdcard0
IF /i %pullf%==\sdcard0\ set pullf=/storage/sdcard0
IF /i %pullf%==sdcard0\ set pullf=/storage/sdcard0
IF /i %pullf%==/9016-4EF8/ set pullf=/storage/9016-4EF8
IF /i %pullf%==/9016-4EF8 set pullf=/storage/9016-4EF8
IF /i %pullf%==9016-4EF8/ set pullf=/storage/9016-4EF8
IF /i %pullf%==\9016-4EF8 set pullf=/storage/9016-4EF8
IF /i %pullf%==9016-4EF8\ set pullf=/storage/9016-4EF8
IF /i %pullf%==/9016-4EF8\ set pullf=/storage/9016-4EF8
IF /i %pullf%==/storage/9016-4EF8/ set pullf=/storage/9016-4EF8
IF /i %pullf%==/sdcard0/pictures/ set pullf=/sdcard0/pictures
IF /i %pullf%==sdcard0/pictures/ set pullf=/sdcard0/pictures
IF /i %pullf%==/sdcard0/videos/ set pullf=/sdcard0/videos
IF /i %pullf%==sdcard0/videos/ set pullf=/sdcard0/videos
IF /i %pullf%==/sdcard0/files/ set pullf=/sdcard0/files
IF /i %pullf%==sdcard0/files/ set pullf=/sdcard0/files

:: FILEPUSH OP6 for pushff0 and pushnative
:pushff0in
IF /i %pushf%==/sdcard/ set pushf=/sdcard
IF /i %pushf%==\sdcard\ set pushf=/sdcard
IF /i %pushf%==sdcard\ set pushf=/sdcard
IF /i %pushf%==\sdcard set pushf=/sdcard
IF /i %pushf%==sdcard set pushf=/sdcard
IF /i %pushf%==sdcard/ set pushf=/sdcard
IF /i %pushf%==/internal/ set pushf=/internal
IF /i %pushf%==internal set pushf=/internal
IF /i %pushf%==/internalsd/ set pushf=/internalsd
IF /i %pushf%==/sdcard/pictures/ set pushf=/sdcard/pictures
IF /i %pushf%==sdcard/pictures/ set pushf=/sdcard/pictures
IF /i %pushf%==/sdcard/videos/ set pushf=/sdcard/videos
IF /i %pushf%==sdcard/videos/ set pushf=/sdcard/videos
IF /i %pushf%==/sdcard/files/ set pushf=/sdcard/files
IF /i %pushf%==sdcard/files/ set pushf=/sdcard/files
:pushff0ex
IF /i %pushf%==sdcard0 set pushf=/storage/sdcard0
IF /i %pushf%==/sdcard0 set pushf=/storage/sdcard0
IF /i %pushf%==/storage/sdcard0/ set pushf=/storage/sdcard0
IF /i %pushf%==/storage/ set pushf=/storage
IF /i %pushf%==/sdcard0/ set pushf=/storage/sdcard0
IF /i %pushf%==sdcard0/ set pushf=/storage/sdcard0
IF /i %pushf%==\sdcard0\ set pushf=/storage/sdcard0
IF /i %pushf%==sdcard0\ set pushf=/storage/sdcard0
IF /i %pushf%==/9016-4EF8/ set pushf=/storage/9016-4EF8
IF /i %pushf%==/9016-4EF8 set pushf=/storage/9016-4EF8
IF /i %pushf%==9016-4EF8/ set pushf=/storage/9016-4EF8
IF /i %pushf%==\9016-4EF8 set pushf=/storage/9016-4EF8
IF /i %pushf%==9016-4EF8\ set pushf=/storage/9016-4EF8
IF /i %pushf%==/9016-4EF8\ set pushf=/storage/9016-4EF8
IF /i %pushf%==/storage/9016-4EF8/ set pushf=/storage/9016-4EF8
IF /i %pushf%==/sdcard0/pictures/ set pushf=/sdcard0/pictures
IF /i %pushf%==sdcard0/pictures/ set pushf=/sdcard0/pictures
IF /i %pushf%==/sdcard0/videos/ set pushf=/sdcard0/videos
IF /i %pushf%==sdcard0/videos/ set pushf=/sdcard0/videos
IF /i %pushf%==/sdcard0/files/ set pushf=/sdcard0/files
IF /i %pushf%==sdcard0/files/ set pushf=/sdcard0/files

:: SCREENSHOT OP51
:scrspin
IF /i %scrsp%==/sdcard/ set scrsp=/sdcard
IF /i %scrsp%==\sdcard\ set scrsp=/sdcard
IF /i %scrsp%==sdcard\ set scrsp=/sdcard
IF /i %scrsp%==\sdcard set scrsp=/sdcard
IF /i %scrsp%==sdcard set scrsp=/sdcard
IF /i %scrsp%==sdcard/ set scrsp=/sdcard
IF /i %scrsp%==/internal/ set scrsp=/internal
IF /i %scrsp%==internal set scrsp=/internal
IF /i %scrsp%==/internalsd/ set scrsp=/internalsd
IF /i %scrsp%==/sdcard/pictures/ set scrsp=/sdcard/pictures
IF /i %scrsp%==sdcard/pictures/ set scrsp=/sdcard/pictures
:scrspex
IF /i %scrsp%==sdcard0 set scrsp=/storage/sdcard0
IF /i %scrsp%==/sdcard0 set scrsp=/storage/sdcard0
IF /i %scrsp%==/storage/sdcard0/ set scrsp=/storage/sdcard0
IF /i %scrsp%==/storage/ set scrsp=/storage
IF /i %scrsp%==/sdcard0/ set scrsp=/storage/sdcard0
IF /i %scrsp%==sdcard0/ set scrsp=/storage/sdcard0
IF /i %scrsp%==\sdcard0\ set scrsp=/storage/sdcard0
IF /i %scrsp%==sdcard0\ set scrsp=/storage/sdcard0
IF /i %scrsp%==/9016-4EF8/ set scrsp=/storage/9016-4EF8
IF /i %scrsp%==/9016-4EF8 set scrsp=/storage/9016-4EF8
IF /i %scrsp%==9016-4EF8/ set scrsp=/storage/9016-4EF8
IF /i %scrsp%==\9016-4EF8 set scrsp=/storage/9016-4EF8
IF /i %scrsp%==9016-4EF8\ set scrsp=/storage/9016-4EF8
IF /i %scrsp%==/9016-4EF8\ set scrsp=/storage/9016-4EF8
IF /i %scrsp%==/storage/9016-4EF8/ set scrsp=/storage/9016-4EF8
IF /i %scrsp%==/sdcard0/pictures/ set scrsp=/sdcard/pictures
IF /i %scrsp%==sdcard0/pictures/ set scrsp=/sdcard/pictures

:: SCREENRECORDING scrbegin11
:scrpin
IF /i %scrp%==/sdcard/ set scrp=/sdcard
IF /i %scrp%==\sdcard\ set scrp=/sdcard
IF /i %scrp%==sdcard\ set scrp=/sdcard
IF /i %scrp%==\sdcard set scrp=/sdcard
IF /i %scrp%==sdcard set scrp=/sdcard
IF /i %scrp%==sdcard/ set scrp=/sdcard
IF /i %scrp%==/internal/ set scrp=/internal
IF /i %scrp%==internal set scrp=/internal
IF /i %scrp%==/internalsd/ set scrp=/internalsd
IF /i %scrp%==/sdcard/video/ set scrp=/sdcard/video
IF /i %scrp%==sdcard/video/ set scrp=/sdcard/video
:scrpex
IF /i %scrp%==sdcard0 set scrp=/storage/sdcard0
IF /i %scrp%==/sdcard0 set scrp=/storage/sdcard0
IF /i %scrp%==/storage/sdcard0/ set scrp=/storage/sdcard0
IF /i %scrp%==/storage/ set scrp=/storage
IF /i %scrp%==/sdcard0/ set scrp=/storage/sdcard0
IF /i %scrp%==sdcard0/ set scrp=/storage/sdcard0
IF /i %scrp%==\sdcard0\ set scrp=/storage/sdcard0
IF /i %scrp%==sdcard0\ set scrp=/storage/sdcard0
IF /i %scrp%==/9016-4EF8/ set scrp=/storage/9016-4EF8
IF /i %scrp%==/9016-4EF8 set scrp=/storage/9016-4EF8
IF /i %scrp%==9016-4EF8/ set scrp=/storage/9016-4EF8
IF /i %scrp%==\9016-4EF8 set scrp=/storage/9016-4EF8
IF /i %scrp%==9016-4EF8\ set scrp=/storage/9016-4EF8
IF /i %scrp%==/9016-4EF8\ set scrp=/storage/9016-4EF8
IF /i %scrp%==/storage/9016-4EF8/ set scrp=/storage/9016-4EF8
IF /i %scrp%==/sdcard0/video/ set scrp=/sdcard/video
IF /i %scrp%==sdcard0/video/ set scrp=/sdcard/video


exit /b
:: SuroADB Comparison Database : [Status] [#vVersion] [Date]
:: SuroADB Comparison Database : Offline 1v11 92918
:: SuroADB Comparison Database : Offline 2v11b4 10118
:: SuroADB Comparison Database : Offline 3v121bC 11118
:: SuroADB Comparison Database : Online 3v121bD 11118
