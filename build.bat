@ECHO off

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
IF EXIST build (RD /S /Q build)
MKDIR build
COPY /y NUL build\dict >NUL

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
COPY sk_SK.aff build\sk_fl.aff

%hunspell% -d build/sk_fl -l build/sk_noflag.dic >build/add.words
%dos2unix% build/add.words
%sed% 1,1d build/sk_fl.dic > build/temp.dic
%cat% build/add.words >> build/temp.dic
%sort% -u <build/temp.dic >build/sk_SK.dic

FOR /f "tokens=2 delims==" %%a IN ('wmic OS Get localdatetime /value') DO SET "dt=%%a"
SET "YYYY=%dt:~0,4%" & SET "MM=%dt:~4,2%" & SET "DD=%dt:~6,2%"
SET "datestamp=%YYYY%%MM%%DD%"
IF NOT EXIST "sk_SK.dic-%datestamp%.bak" (
    IF EXIST sk_SK.dic (ren "sk_SK.dic" "sk_SK.dic-%datestamp%.bak")
)

%wc% -l < build/sk_SK.dic | %cat% - build/sk_SK.dic >sk_SK.dic

REM Clean up
REM rmdir /s/q build

ECHO Finished.
