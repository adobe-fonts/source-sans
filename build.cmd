@echo off
setlocal

set FAMILY=SourceSans3
set UPRIGHT_WEIGHTS=Black Bold ExtraLight Light Regular Semibold
set ITALIC_WEIGHTS=BlackIt BoldIt ExtraLightIt LightIt It SemiboldIt

:: find makeotf
for /f %%a in ('where makeotf') do set MAKEOTF_PATH=%%a
if "%MAKEOTF_PATH%" == "" goto error_makeotf_not_found

call :GetDirectoryName PYTHON_PATH "%MAKEOTF_PATH%"

set TARGET_PATH=%~dp0\target\
set TARGET_OTF_PATH=%TARGET_PATH%OTF\
set TARGET_TTF_PATH=%TARGET_PATH%TTF\

if exist "%TARGET_PATH%" rmdir /s /q "%TARGET_PATH%"
mkdir "%TARGET_OTF_PATH%"
mkdir "%TARGET_TTF_PATH%"

set x=%UPRIGHT_WEIGHTS%
:loop_upright
for /f "tokens=1*" %%a in ("%x%") do (
    call :build_font Upright %%a
    set x=%%b
)
if defined x goto :loop_upright

set x=%ITALIC_WEIGHTS%
:loop_italic
for /f "tokens=1*" %%a in ("%x%") do (
    call :build_font Italic %%a
    set x=%%b
)
if defined x goto :loop_italic

endlocal
goto :eof

:: Build Font
:: %1 - Upright/Italic
:: %2 - Weight
:build_font
call makeotf -f "%~dp0\%1\Instances\%2\font.ufo" -r -o "%TARGET_OTF_PATH%\%FAMILY%-%2.otf"
call makeotf -f "%~dp0\%1\Instances\%2\font.ttf" -r -o "%TARGET_TTF_PATH%\%FAMILY%-%2.ttf" -ff "%~dp0\%1\Instances\%2\font.ufo\features.fea"
goto :eof

:error_makeotf_not_found
echo makeotf command not found. Install Adobe Font Development Kit for OpenType (http://www.adobe.com/devnet/opentype/afdko.html).
endlocal
exit /b 1

::
:: Get directory name from full path name.
:: Usage:
::   GetDirectoryName VARIABLE VALUE
::
:GetDirectoryName
call set %~1=%~dp2
goto :eof
