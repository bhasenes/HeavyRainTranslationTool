@echo off
title Heavy Rain Translation Tool
cd /d "%~dp0"
if not exist "%~dp0HeavyRainTranslationTool.exe" goto noexe
"%~dp0HeavyRainTranslationTool.exe" extract-texts
echo.
pause
exit /b

:noexe
echo HeavyRainTranslationTool.exe was not found next to this file.
echo Extract the whole tool folder and run the .bat files from there.
echo.
pause
