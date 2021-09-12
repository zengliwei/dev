@echo off

::::
:: Create batch down site script
::
echo call %~dp0cmd\reset-proxy-config.cmd > "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\stop-docker-projects.cmd"

::::
:: Add host mapping
::
set hostMappingSet=0
set hostFile=%SystemRoot%\System32\drivers\etc\hosts
for /f "tokens=1,2" %%i in (%hostFile%) do (
  if %%j == db.localhost set hostMappingSet=1
)
if %hostMappingSet% == 0 (
  echo. >> %hostFile%
  echo. >> %hostFile%
  echo 127.0.0.1 db.localhost >> %hostFile%
  echo 127.0.0.1 mail.localhost >> %hostFile%
)

::::
:: Create containers
::
docker-compose up --no-recreate -d
