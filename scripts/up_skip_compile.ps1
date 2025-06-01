# up_skip_compile.ps1

# Set UID:GID environment variable (fallback for Windows)
$env:UID_GID = "1000:1000"

# Ensure mount directories exist
foreach ($dir in @("mars", "api", "server")) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}

# Skip compilation steps – they're commented out in the original
# You can re-enable or move this logic elsewhere if needed

# Sanity checks: ensure build outputs exist
if (-not (Test-Path "mars/build")) {
    Write-Host "Mars build dir doesn't exist!"
    exit 1
}
if (-not (Test-Path "api/target")) {
    Write-Host "mars-api-rs target dir doesn't exist!"
    exit 1
}

# Start MC server and services
docker-compose up -d mcsrv

Read-Host -Prompt "Press Enter to exit"