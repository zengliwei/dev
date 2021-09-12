::::
:: Start Project
:: - Start container
:: - Rename related router config file name
:: - Reload router
::::

@echo off

set domain=%~1
set configPath=%~dp0..\config

rename "%configPath%\router\%domain%" "%domain%.conf"
docker-compose start
docker exec dev_router /usr/sbin/service nginx reload
