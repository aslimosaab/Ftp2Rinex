@echo off
cls
echo.
type sign.txt
echo.
type header.txt
echo.
set /p user=<1username.txt
set /p pass=<1password.txt
set /p ftp=<1ip.txt
echo user:%user% pass:%pass% ftp:%ftp% output_path:%output%
timeout 5
lftp -u %user%,%pass% -e "cd Internal; ls * > log.txt; quit" %ftp%
timeout 1
for /f %%a in (log.txt) do (
    lftp -u %user%,%pass% -e "cd Internal; cd %%a; ls *.RINEX.2.11.zip > log%%a.txt; quit" %ftp%
    for /f %%b in (log%%a.txt) do (
    echo Downloading ftp://%ftp%/Internal/%%a/%%b PLEASE WAIT.
    wget -nc --no-verbose --user %user% --password %pass% ftp://%ftp%/Internal/%%a/%%b -p /
    )
)
echo.
type sign2.txt
echo.
timeout 1
cls
timeout 1
exit