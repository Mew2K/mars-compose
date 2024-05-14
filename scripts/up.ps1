# Ensure Docker is set to Windows containers (manually ensure this before running the script)

# Set up directories
$dirs = @("mars", "api", "server")
foreach ($dir in $dirs) {
    if (-Not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir
    }
}

# Start the compilation tasks in the background
Start-Process "docker-compose" -ArgumentList "up", "api_compile", "mars_compile", "-d" -NoNewWindow -Wait

# Start the mars_compile container and run the compile script in the background
$job = Start-Job -ScriptBlock {
    docker exec mars_compile 'powershell.exe -File C:\workspace\compile_mars.ps1'
}

# Attach to api_compile logs
docker logs -f api_compile

# Wait for the background job to complete
Wait-Job -Id $job.Id

# Stop the api_compile container
docker stop api_compile

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