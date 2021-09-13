::::
:: Add Host Record
::::

@echo off

set domain=%~1
set hostFile=%SystemRoot%\System32\drivers\etc\hosts

(for /f "tokens=1 delims=:" %%i in ('findstr /n /c:"%domain%" "%hostFile%"') do (
    echo %%i
))>lines.tmp

copy %hostFile% hosts.tmp >nul

setLocal enableDelayedExpansion
(for /f "tokens=1* delims=:" %%l in ('findstr /n .* hosts.tmp') do (
    set print=true
    for /f %%i in (lines.tmp) do (
        if %%l == %%i set print=false
    )
    if not !print! == false (
        echo;%%m
    )
))>%hostFile%
endLocal

del lines.tmp
del hosts.tmp
