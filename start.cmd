@echo off
echo rename %CD%\config\router\*.conf *. > "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\stop-docker-projects.cmd"
cd ./src
docker-compose up -d