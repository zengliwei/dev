::::
:: Append database information in phpMyAdmin config file
::::

@echo off

set project=%~1
set configFile=%~dp0..\config\phpmyadmin\config.user.inc.php

setLocal enableDelayedExpansion
for /f "tokens=1 delims=:" %%i in ('findstr /n /c:"'host'      => '%project%_mysql'" %configFile%') do (
    set /a start=%%i - 2
    set /a end=!start! + 6
    (for /f "tokens=1* delims=:" %%l in ('findstr /n .* %configFile%') do (
        if %%l lss !start! (
            echo;%%m
        ) else if %%l gtr !end! (
            echo;%%m
        )
    ))>config.user.inc.php.tmp
    move /y config.user.inc.php.tmp %configFile%
)
endLocal
