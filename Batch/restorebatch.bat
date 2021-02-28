@echo off
title Restoring Features - Readme
color a
echo (!) Warning (!)
echo This script may can cause harm to your system. By launch this application you will agree and you'll understand these risks.
echo.
echo This script starts automatically after 5 seconds.
ping 127.0.0.1 -n 6 > nul
cls
echo.
title Recovering Files... (1/11)
echo Recovering C:/Windows/system32/net.exe ...
SFC /ScanFile="C:\Windows\system32\net.exe"
cls
title Recovering Files... (2/11)
cls
echo.
echo.
title Before using NET - Warning
echo (!) Before starting to use net, please wait until Restoring Features will restore your Group Policy (after this task).
echo. (!) You can still manage the user accounts by using WMIC or using Group Policy Editor.
echo.
echo Press a key to continue ...
pause -nul
echo.
cls
echo Recovering Shutdown (shutdown.exe) ...
SFC /ScanFile="C:\Windows\system32\shutdown.exe"
cls
title Recovering Files... (3/11)
echo Recovering MountVol (mountvol.exe) ...
SFC /ScanFile="C:\Windows\system32\mountvol.exe"
cls
title Recovering Files... (4/11)
echo Recovering Logoff (logoff.exe) ...
SFC /ScanFile="C:\Windows\system32\logoff.exe"
cls
title Recovering Files... (5/11)
echo Recovering netl (net1.exe) ...
SFC /ScanFile="C:\Windows\system32\net1.exe"
cls
title Recovering Files... (6/11)
echo Recovering DiskPart (diskpart.exe) ...
SFC /ScanFile="C:\Windows\system32\diskpart.exe"
cls
title Recovering Files... (7/11)
echo Recovering Local Users and Groups Manager (lusrmgr.msc) ...
SFC /ScanFile="C:\Windows\system32\lusrmgr.msc"
cls
title Recovering Files... (8/11)
echo Recovering Computer Management (compmgmt.msc) ...
SFC /ScanFile="C:\Windows\system32\compmgmt.msc"
cls
title Recovering Files... (9/11)
echo Recovering Device Manager (devmgmt.msc) ...
SFC /ScanFile="C:\Windows\system32\devmgmt.msc"
cls
title Recovering Files... (10/11)
echo Recovering C:/Windows/system32/reg.exe
SFC /ScanFile="C:\Windows\system32\reg.exe"
title Recovering Files... (11/11)
cls
title Removing Group Policy Settings...
echo This part removes your GroupPolicy and your GroupPolicyUsers in System32.
echo This will not very likely gonna harm your system, since it will force gpedit to reset the default settings.
secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose
RD /S /Q "%WinDir%\System32\GroupPolicy"
RD /S /Q "%WinDir%\System32\GroupPolicyUsers"
gpupdate /force
cls
title Removing Restrictions... (0/3)
echo This part removes other restrictions, please wait.
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft" /f
title Disabling Software Restriction Policy (1/3)
echo Disabling Software Restriction Policy ...
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\ /v DefaultLevel /t REG_DWORD /d 0x00040000 /f
cls
title Just a moment... (2/3)
echo Deleting Policies\Explorer\DisallowRun ...
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /f
cls
echo Done.
cls
title Rebooting... (3/3)
REG ADD HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\ /v DefaultLevel /t REG_DWORD /d 0x00040000 /f 
shutdown /r /f /t 100 /c "Restoring Features will restart your computer in 1 minutes, save your work before rebooting!" /d p:4:1
msg * /v Restoring Features will restart your computer in 1 minute, save your work before rebooting!
cls
title Task completed
color a
echo Restored successfully.
echo You need to see the changes at your Start Menu (you should see a Shutdown button if done correctly)
echo Please wait for the restart to finish Restoring Features remaining tasks.
echo.
echo Press any key to quit ...
pause -nul
