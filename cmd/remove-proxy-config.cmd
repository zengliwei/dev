::::
:: Remove Project
::::

@echo off

set domain=%~1
set routerConfigDir=%~dp0..\config\router
set sslConfigDir=%~dp0..\config\ssl

for /f %%f in ('dir /b %routerConfigDir%') do (
    if %%f == %domain% (
        del %routerConfigDir%\%%f
        echo Proxy config file %%f is removed.
    ) else if %%f == %domain%.conf (
        del %routerConfigDir%\%%f
        echo Proxy config file %%f is removed.
    )
)

for /f %%f in ('dir /b %sslConfigDir%') do (
    if %%f == %domain%.browser.cer (
        del %sslConfigDir%\%%f
        echo SSL config file %%f is removed.
    ) else if %%f == %domain%.browser.pvk (
        del %sslConfigDir%\%%f
        echo SSL config file %%f is removed.
    ) else if %%f == %domain%.cer (
        del %sslConfigDir%\%%f
        echo SSL config file %%f is removed.
    ) else if %%f == %domain%.pvk (
        del %sslConfigDir%\%%f
        echo SSL config file %%f is removed.
    )
)
