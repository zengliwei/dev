::::
:: Create Proxy Config File
::::

@echo off

set project=%~1
set domain=%~2
set proxySet=0
set configPath=%~dp0..\config\router

for /f %%i in ( 'dir /b %configPath%' ) do (
    if %%i == %domain% set proxySet=1
    if %%i == %domain%.conf set proxySet=1
)

if %proxySet% == 0 (
    setLocal enableDelayedExpansion
    (for /f "tokens=1* delims=:" %%k in ('findstr /n .* .\config\router\proxy.conf') do (
        set "line=%%l"
        if "!line!" == "" (
            echo;
        ) else (
            set line=!line:project_name=%project%!
            set line=!line:project_domain=%domain%!
            echo;!line!
        )
    ))>%configPath%\%domain%
    endLocal

    call %~dp0create-ssl-cert.cmd "%domain%"
)
