::::
:: Add Host Record
::::

@echo off

set hostMappingSet=0
set hostFile=%SystemRoot%\System32\drivers\etc\hosts

for /f "tokens=1,2" %%i in (%hostFile%) do (
    if %%j == %domain% set hostMappingSet=1
)

if %hostMappingSet% == 0 (
    echo.>> %hostFile%
    echo.>> %hostFile%

    for %%f in (%~1 %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9) do (
        echo 127.0.0.1 %%f>> %hostFile%
    )
)
