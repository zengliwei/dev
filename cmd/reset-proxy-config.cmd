::::
:: Reset proxy config files of which projects are no restart
::::

@echo off

set projectsDir=%~dp0..\projects
set configDir=%~dp0..\config\router

setLocal enableDelayedExpansion
for /f %%p in ('dir /b %projectsDir%') do (
    set file=%projectsDir%\%%p\.env
    if exist !file! (
        for /f "tokens=1,2 delims==" %%i in (!file!) do (
            if %%i == DOMAIN (
                set domain=%%j
            ) else if %%i == RESTART (
                set restart=%%j
            )
        )
        if not "!domain!" == "" (
            if !restart! == no (
                if exist %configDir%\!domain!.conf (
                    rename %configDir%\!domain!.conf !domain!
                )
            )
        )
    )
)
endLocal
