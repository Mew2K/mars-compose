FROM mcr.microsoft.com/windows/servercore:ltsc2019
WORKDIR /workspace
COPY compile_api.ps1 /workspace/compile_api.ps1
CMD ["powershell.exe", "-File", "/workspace/compile_api.ps1"]
