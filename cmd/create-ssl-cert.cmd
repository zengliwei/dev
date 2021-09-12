::::
:: Create SSL Certificate
::::

@echo off

set domain=%~1
set configPath=%~dp0..\config\ssl

for /f "tokens=1* delims=:" %%k in ('findstr /n .* .\config\router\ssl.conf') do (
    set "line=%%l"
    setLocal enableDelayedExpansion
        if "!line!" == "" (
        echo.>> ssl.conf.tmp
    ) else (
        set line=!line:project_domain=%domain%!
        echo !line!>> ssl.conf.tmp
    )
    endLocal
)
move ssl.conf.tmp %configPath%\ext.cnf

docker exec dev_router /usr/bin/openssl req -x509 -nodes -sha256 -newkey rsa:2048 -outform PEM -days 3650 -addext "basicConstraints=critical, CA:true" -subj "/C=CN/ST=State/L=Locality/O=Organization/CN=Dev - %domain%" -keyout ca.pvk -out /etc/ssl/certs/%domain%.browser.cer
docker exec dev_router /usr/bin/openssl req -nodes -sha256 -newkey rsa:2048 -out server.req -keyout /etc/ssl/certs/%domain%.pvk -subj "/C=CN/ST=State/L=Locality/O=Organization/CN=%domain%"
docker exec dev_router /usr/bin/openssl x509 -req -sha256 -days 3650 -set_serial 0x1111 -extfile /etc/ssl/certs/ext.cnf -in server.req -CAkey ca.pvk -CA /etc/ssl/certs/%domain%.browser.cer -out /etc/ssl/certs/%domain%.cer
docker exec dev_router rm ca.pvk server.req /etc/ssl/certs/ext.cnf
