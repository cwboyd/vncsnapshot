@echo off
setlocal enabledelayedexpansion

:: 1. Get the current date in standard YYYY-MM-DD format using WMIC (avoids regional setting errors)
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "dt=%%I"
set "YYYY-MM-DD=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%"

:: 2. Define your desired base filename, target extension, and starting index (0).  Change path from X:\ to whatever you want.
set "BASE_NAME=x:\%YYYY-MM-DD%-snapshot-"
set "EXTENSION=.jpg"
set /a "COUNT=0"

:: 3. Loop to check if the serialized file already exists, incrementing the counter if it does
:LOOP
:: Formats the index with leading zeros (e.g., 0 becomes 000, 1 becomes 001)
set "NUM=000%COUNT%"
set "SERIAL=%NUM:~-3%"
set "FILE_NAME=%BASE_NAME%%SERIAL%%EXTENSION%"

if exist "%FILE_NAME%" (
    set /a "COUNT+=1"
    goto LOOP
)

:: 4. Create the serialized file
echo Creating serialized snapshot: %FILE_NAME%

echo SECRET | vncsnapshot.exe IP_ADDR %FILE_NAME%

endlocal
pause



