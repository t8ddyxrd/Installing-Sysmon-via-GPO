@echo off
SET CONFIG_SRC=\\YourServer\SysmonShare\config.xml
SET CONFIG_DEST=C:\Windows\config.xml
SET SYSMON_EXE=\\YourServer\SysmonShare\sysmon.exe
SET LOGFILE=C:\Windows\SysmonDeploy.log

echo [%DATE% %TIME%] Starting Sysmon deployment >> %LOGFILE%

if not exist "%CONFIG_SRC%" (
    echo [%DATE% %TIME%] ERROR: Cannot reach %CONFIG_SRC% >> %LOGFILE%
    exit /b 1
)

copy /y "%CONFIG_SRC%" "%CONFIG_DEST%" >nul
if %ERRORLEVEL% neq 0 (
    echo [%DATE% %TIME%] ERROR: Failed to copy config file >> %LOGFILE%
    exit /b 1
) else (
    echo [%DATE% %TIME%] INFO: Config file copied >> %LOGFILE%
)

sc query "Sysmon" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [%DATE% %TIME%] INFO: Sysmon not found. Installing... >> %LOGFILE%
    "%SYSMON_EXE%" /accepteula -i "%CONFIG_DEST%" >> %LOGFILE% 2>&1
) else (
    echo [%DATE% %TIME%] INFO: Sysmon found. Updating config... >> %LOGFILE%
    "%SYSMON_EXE%" -c "%CONFIG_DEST%" >> %LOGFILE% 2>&1
)

sc query "Sysmon" | find "RUNNING" >nul
if %ERRORLEVEL% neq 0 (
    echo [%DATE% %TIME%] WARNING: Sysmon not running. Starting... >> %LOGFILE%
    net start Sysmon >> %LOGFILE% 2>&1
)

echo [%DATE% %TIME%] Sysmon deployment completed >> %LOGFILE%
exit /b 0
