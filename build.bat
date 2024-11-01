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
SET hunspell="F:\Projects\Personal\sk-spell\devel\hunspell\msvc\Release\hunspell\hunspell.exe"

IF NOT EXIST Backups (MKDIR Backups)

REM BUILD Process
REM ***** get rid of all the old files in the build folder
IF EXIST build (RD /S /Q build)
MKDIR build
COPY /y NUL build\dict >NUL


FOR %%f IN (_osobnosti/sport.dic, _osobnosti/politika.dic, _osobnosti/it.dic, _osobnosti/rozne.dic, _skratky/it.dic, _skratky/geografia.dic, _skratky/politika.dic, _skratky/rozne.dic, _tematicke/nabozenske.dic, _tematicke/cudzie.dic, _terminy/it.dic, sk_SK.dic) DO (
    %sed% 1,1d %%f | %sed% "$a\\n" >> build/dict
)

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
IF NOT EXIST "Backups/sk_SK.dic-%datestamp%.bak" (
    IF EXIST sk_SK.dic (move "sk_SK.dic" "Backups/sk_SK.dic-%datestamp%.bak")
)

%wc% -l < build/sk_SK.dic | %cat% - build/sk_SK.dic >sk_SK.dic

copy sk_SK.dic "C:\Program Files\LibreOffice\share\extensions\dict-sk"
copy sk_SK.aff "C:\Program Files\LibreOffice\share\extensions\dict-sk"

REM Clean up
REM rmdir /s/q build

ECHO Finished.
