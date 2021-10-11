@Echo off

CHCP 65001
SET LC_ALL=sk_SK.UTF-8

REM Requirements: https://git-scm.com/download/win
SET wc="C:\Program Files\Git\usr\bin\wc.exe"
SET cat="C:\Program Files\Git\usr\bin\cat.exe"
SET sed="C:\Program Files\Git\usr\bin\sed.exe"
SET sort="C:\Program Files\Git\usr\bin\sort.exe"
SET grep="C:\Program Files\Git\usr\bin\grep.exe"
SET dos2unix="C:\Program Files\Git\usr\bin\dos2unix.exe"
SET hunspell="F:\Project-Personal\sk-spell\devel\hunspell\msvc\Release\hunspell\hunspell.exe"

REM BUILD Process
REM ***** get rid of all the old files in the build folder
IF exist build ( rd /S /Q build)
mkdir build
copy /y NUL build\dict >NUL

%sed% 1,1d _osobnosti/sport.dic >>build/dict
%sed% 1,1d _osobnosti/politika.dic >>build/dict
%sed% 1,1d _osobnosti/it.dic >>build/dict
%sed% 1,1d _skratky/it.dic >>build/dict
%sed% 1,1d _skratky/politika.dic >>build/dict
%sed% 1,1d _tematicke/nabozenske.dic >>build/dict
%sed% 1,1d _tematicke/cudzie.dic >>build/dict
%sed% 1,1d _terminy/it.dic >>build/dict
%sed% 1,1d sk_SK.dic >>build/dict

%sort% -u build/dict > build/temp.dic
%grep% -v "/" build/temp.dic | %grep% -v ":" >build/sk_noflag.dic
%grep% -v "/" build/temp.dic | %grep% ":" >build/sk_fl.tmp
%grep% "/" build/temp.dic >>build/sk_fl.tmp
%wc% -l < build/sk_fl.tmp | %cat% - build/sk_fl.tmp | %sort% -u >build/sk_fl.dic
copy sk_SK.aff build\sk_fl.aff

%hunspell% -d build/sk_fl -l build/sk_noflag.dic >build/add.words
%dos2unix% build/add.words
%sed% 1,1d build/sk_fl.dic > build/temp.dic
%cat% build/add.words >> build/temp.dic
%sort% -u <build/temp.dic >build/sk_SK.dic
%wc% -l < build/sk_SK.dic | %cat% - build/sk_SK.dic >sk_SK.new.dic

REM Clean up
REM rmdir /s/q build

echo Finished.
