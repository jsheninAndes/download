@echo OFF
:: echo Copyright (C) 2022 Andes Technology Corporation.

set CURRENT_DIR=""%cd%""
cd /d %CURRENT_DIR%

:checkWmic
wmic.exe os get oslanguage > nul
if errorlevel 1 goto UnknownWmic

:SetLanguage
:: wmic.exe os get locale, oslanguage, codeset
for /F "tokens=*" %%a in ('wmic.exe os get oslanguage ^| findstr "[0,9]"') do @set LCID=%%a
if %LCID% == 2052 (
	START /B InstData\VM\install.exe -l zh_CN
) else if %LCID% == 1041 (
	START /B InstData\VM\install.exe -l ja
) else (
	START /B InstData\VM\install.exe -l en
)
goto END

:UnknownWmic
START /B InstData\VM\install.exe

:END
