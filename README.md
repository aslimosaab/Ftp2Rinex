# Ftp2Rinex
Download rinex files from trimble NetR9 FTP server for Windows<br/>
Check http://kb.unavco.org/kb/article/trimble-netr9-resource-page-673.html for resources.

    1ip.txt---------------------------------->Set Host/Ip adress
    1output.txt------------------------------>Set Output path
    1password.txt---------------------------->Set login Password
    1username.txt---------------------------->Set login User
    bash.exe
    COPYING
    cygasn1-8.dll
    cygcom_err-2.dll
    cygcrypt-0.dll
    cygcrypto-1.0.0.dll
    cyggcc_s-1.dll
    cyggssapi-3.dll
    cygheimbase-1.dll
    cygheimntlm-0.dll
    cyghx509-5.dll
    cygiconv-2.dll
    cygintl-8.dll
    cygkrb5-26.dll
    cygncursesw-10.dll
    cygreadline7.dll
    cygroken-18.dll
    cygsqlite3-0.dll
    cygssl-1.0.0.dll
    cygssp-0.dll
    cygwin1.dll
    cygwind-0.dll
    cygz.dll
    header.txt
    lftp.conf
    lftp.exe
    sign.txt
    sign2.txt
    ssh.exe
    Start_HERE_v1.0.2.bat------------------------------------------------------------>Start batScript here.
    wget.exe
    wget.exe.gdb
    wget.html


This Script uses lftp and wget libraries<br/>
The TREE of the Trimble NetR9 FTP server has always the same Structure<br/>
Internal/DateDependingFolders/AllFiles(Rinex different versions, T02)<br/>
Exteral/EmptyFolder<br/>


```batch
Start_HERE_v1.0.2.bat:
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
set /p output=<1output.txt
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
SET COPYCMD=/Y
xcopy myPath %output% /e /i /y /s 
timeout 1
echo.
type sign2.txt
echo.
timeout 1
cls
timeout 1
exit
```
You can add the start_HERE_v1.0.2.bat to Windows-Task-Scheduler to auto download Rinex periodically.
