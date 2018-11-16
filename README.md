# Ftp2Rinex
Download rinex files from trimble NetR9 FTP server for Windows<br/>
Check http://kb.unavco.org/kb/article/trimble-netr9-resource-page-673.html for resources.

    1ip.txt
    1password.txt
    1username.txt
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
    Start_Batch_v1.0.2.bat
    wget.exe
    wget.exe.gdb
    wget.html


This Script uses lftp and wget libraries<br/>
The TREE of the Trimble NetR9 FTP server has always the same Structure<br/>
Internal/DateDependingFolders/AllFiles(Rinex different versions, T02)<br/>
Exteral/EmptyFolder<br/>


```batch
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
exit```

HOW DOES IT WORK :

1. Download the entire repository

2. Extract the zip file

3. You need to modify 3-text files

         Set the IP-Address you want to connect to:

   3.1 1ip.txt---------------------------->Add your FTP address

         Set the output path, Where to save the downloaded files ?:

   3.2 1password.txt---------------------->Write your Password

   3.3 1username.txt---------------------->Write your Username

4. Open the BAT file: Start_Batch_v1.0.2.bat (Double Click or Run in CMD)



The Rinex files are downloaded to the same folder where you saved this repository.

You can add the start_Batch_v1.0.2.bat to Windows-Task-Scheduler to auto download Rinex periodically.
