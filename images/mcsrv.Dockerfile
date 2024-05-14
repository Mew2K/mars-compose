FROM mcr.microsoft.com/windows/servercore:ltsc2019
WORKDIR /workspace

# Install wget, git, and unzip using PowerShell
RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Invoke-WebRequest "https://eternallybored.org/misc/wget/1.20.3/64/wget.exe" -OutFile "C:\Windows\System32\wget.exe"; \
    Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v2.29.0.windows.1/Git-2.29.0-64-bit.exe" -OutFile "git-installer.exe"; \
    Start-Process 'git-installer.exe' -ArgumentList '/VERYSILENT' -NoNewWindow -Wait; \
    Remove-Item -Force git-installer.exe; \
    Invoke-WebRequest "https://www.7-zip.org/a/7z1900-x64.exe" -OutFile "unzip-installer.exe"; \
    Start-Process 'unzip-installer.exe' -ArgumentList '/S' -NoNewWindow -Wait; \
    Remove-Item -Force unzip-installer.exe
EXPOSE 25565
COPY mcsrv.ps1 /workspace/mcsrv.ps1
CMD ["powershell.exe", "-File", "/workspace/mcsrv.ps1"]