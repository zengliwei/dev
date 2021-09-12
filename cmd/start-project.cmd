::::
:: Start Project
:: - Start container
:: - Rename related router config file name
:: - Reload router
::::

@echo off

set domain=%~1
set restart=%~2
set configPath=%~dp0..\config\

if "%restart%" == "no" (
    rename "%configPath%\router\%domain%" "%domain%.conf"
)

docker-compose start
docker exec dev_router /usr/sbin/service nginx reload
