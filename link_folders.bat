@echo off
setlocal EnableDelayedExpansion

set "DOTFILES=%~dp0"
if "%DOTFILES:~-1%"=="\" set "DOTFILES=%DOTFILES:~0,-1%"

set "PATHS_FILE=%DOTFILES%\paths.txt"

if not exist "%PATHS_FILE%" (
    echo ERROR: paths.txt not found at %PATHS_FILE%
    pause & exit /b 1
)

echo Dotfiles: %DOTFILES%
echo.

for /f "usebackq tokens=1,* delims==" %%A in ("%PATHS_FILE%") do (
    set "FOLDER=%%A"
    set "TARGET=%%B"

    REM Skip comment and empty lines
    if not "!FOLDER:~0,1!"=="#" if not "!FOLDER!"=="" (

        REM Trim trailing spaces from folder name
        for /l %%i in (1,1,32) do if "!FOLDER:~-1!"==" " set "FOLDER=!FOLDER:~0,-1!"

        REM Trim leading spaces from target path
        for /l %%i in (1,1,8) do if "!TARGET:~0,1!"==" " set "TARGET=!TARGET:~1!"

        set "SOURCE=!DOTFILES!\!FOLDER!"

        REM Expand environment variables in target path (e.g. %APPDATA%)
        call set "TARGET_EXP=!TARGET!"

        if not exist "!SOURCE!\" (
            echo [SKIP]  !FOLDER! -- source folder not found: !SOURCE!
        ) else if exist "!TARGET_EXP!" (
            echo [SKIP]  !FOLDER! -- target already exists: !TARGET_EXP!
        ) else (
            mklink /J "!TARGET_EXP!" "!SOURCE!" >nul 2>&1
            if !errorlevel! equ 0 (
                echo [OK]    !FOLDER! --^> !TARGET_EXP!
            ) else (
                echo [FAIL]  !FOLDER! -- failed to create junction at: !TARGET_EXP!
            )
        )
    )
)

echo.
pause
