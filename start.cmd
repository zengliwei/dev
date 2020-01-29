@echo off

::::
:: Create batch down site script
::
echo rename %CD%\config\router\*.conf *. > %UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\stop-docker-projects.cmd

::::
:: Add host mapping
::
set hostMappingSet=0
for /f "tokens=1,2" %%i in ( %SystemRoot%\System32\drivers\etc\hosts ) do (
  if %%j == db.localhost set hostMappingSet=1
)
if %hostMappingSet% == 1 exit
echo. >> %SystemRoot%\System32\drivers\etc\hosts
echo. >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 localhost >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 db.localhost >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 mail.localhost >> %SystemRoot%\System32\drivers\etc\hosts

::::
:: Create containers
::
docker-compose up --no-recreate -d
