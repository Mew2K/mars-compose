# compile_api_script.ps1

# Set UID:GID equivalent (for Linux containers this may not apply on Windows, but included for parity)
$uid = $(id -u)
$gid = $(id -g)
$env:UID_GID = "$uid`:$gid"

# Create the mount directory if it doesn't exist
if (-not (Test-Path "api")) {
    New-Item -ItemType Directory -Path "api" | Out-Null
}

# Run the Docker container to compile the API
docker-compose up api_compile

# Remove the container after it's done
docker rm api_compile

Read-Host -Prompt "Press Enter to exit"