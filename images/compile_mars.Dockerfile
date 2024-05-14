# Use a Windows base image that supports Java
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Set the working directory in the container
WORKDIR /workspace

# Install Java 8 and Git using PowerShell
RUN powershell -Command \
        $ErrorActionPreference = 'Stop'; \
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
        Invoke-WebRequest -Uri 'https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-x64-14_jan_2020.zip' -OutFile 'openjdk8.zip'; \
        Expand-Archive openjdk8.zip -DestinationPath C:\Java; \
        Remove-Item openjdk8.zip; \
        $env:PATH = 'C:\Java\openjdk-8u41-b04\bin;' + $env:PATH; \
        [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine); \
        Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/download/v2.29.0.windows.1/Git-2.29.0-64-bit.exe' -OutFile 'git-installer.exe'; \
        Start-Process 'git-installer.exe' -ArgumentList '/VERYSILENT' -NoNewWindow -Wait

# Copy your PowerShell script into the container
COPY compile_mars.ps1 /workspace/compile_mars.ps1

# Set the command to run the PowerShell script
CMD ["powershell.exe", "-File", "/workspace/compile_mars.ps1"]
