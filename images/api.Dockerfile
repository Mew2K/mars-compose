FROM mcr.microsoft.com/windows/servercore:ltsc2019
WORKDIR /workspace
COPY api.ps1 /workspace/api.ps1
ENTRYPOINT ["powershell.exe", "-File", "/workspace/api.ps1"]