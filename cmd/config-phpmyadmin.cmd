::::
:: Append database information in phpMyAdmin config file
::::

@echo off

set project=%~1
set dbUser=%~2
set dbPass=%~3
set configFile=%~dp0..\config\phpmyadmin\config.user.inc.php
set phpMyAdminSet=0

for /f "tokens=1,2 delims==> " %%i in ('findstr /c:"%project%_mysql" %configFile%') do (
    if "%%j" == "'%project%_mysql'," set phpMyAdminSet=1
)

if %phpMyAdminSet% == 0 (
    echo.>> %configFile%
    echo $cfg['Servers'][] = [>> %configFile%
    echo     'auth_type' =^> 'config',>> %configFile%
    echo     'host'      =^> '%project%_mysql',>> %configFile%
    echo     'user'      =^> '%dbUser%',>> %configFile%
    echo     'password'  =^> '%dbPass%'>> %configFile%
    echo ];>> %configFile%
)
