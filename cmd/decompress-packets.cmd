::::
:: Decompress packets
::
@echo off

set project=%~1

for /f %%f in ('dir /b .\src') do (
    set "file=%%f"
    setLocal enableDelayedExpansion
    if !file:~-4! == .tar (
        call :COPY_FILE_TO_CONTAINER ".\src" !file! %project%_web "/var/www/current"
        docker exec %project%_web chown www-data:www-data /var/www/current/!file!
        docker exec -u www-data:www-data %project%_web tar -xvf /var/www/current/!file! -C /var/www/current
    ) else if !file:~-7! == .tar.gz (
        call :COPY_FILE_TO_CONTAINER ".\src" !file! %project%_web "/var/www/current"
        docker exec %project%_web chown www-data:www-data /var/www/current/!file!
        docker exec -u www-data:www-data %project%_web tar -zxvf /var/www/current/!file! -C /var/www/current
    )
    endLocal
)
goto :EOF


::::
:: Copy file to docker container and make sure it is completely
::
:COPY_FILE_TO_CONTAINER

    set srcDir=%~1
    set fileName=%~2
    set container=%~3
    set distDir=%~4

    for /f "delims=" %%i in ('dir /s/b %srcDir%\%fileName%') do set fileSize=%%~zi
    docker cp %srcDir%\%fileName% %container%:%distDir%

    :loopCopyFile
    for /f %%s in ('docker exec -it %container% wc -c %distDir%/%fileName%') do (
        if not %%s == %fileSize% (
            ping -n 3 127.0.0.1>nul
            goto loopCopyFile
        )
    )

goto :EOF
