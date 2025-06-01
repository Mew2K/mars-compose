# up_skip_compile.ps1

# Set UID:GID environment variable (fallback for Windows)
# $env:UID_GID = "1000:1000"

$dirs = @("mars", "api", "server")
foreach ($dir in $dirs) {
    if (-Not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir
    }
}

# Skip compilation steps – they're commented out in the original
# You can re-enable or move this logic elsewhere if needed

# Sanity checks to make sure the compilation outputs are present
if (-Not (Test-Path "mars\build")) {
    Write-Host "Mars build dir doesn't exist!"
    exit 1
}
if (-Not (Test-Path "api\target")) {
    Write-Host "mars-api-rs target dir doesn't exist!"
    exit 1
}

# Start the MC server, API, Redis, DB
Start-Process "docker-compose" -ArgumentList "up", "-d", "mcsrv" -NoNewWindow -Wait

Read-Host -Prompt "Press Enter to exit"