# stop_mcserver_compile_plugin_start_mcserver.ps1

# Import utility functions
. "$PSScriptRoot\common_utils.ps1"

# Set UID:GID environment variable (use a fallback for Windows)
$env:UID_GID = "1000:1000"

# Stop the MC server if running
Kill-MCServer

# Compile the plugin
Compile-Plugin

# Start the MC server container in detached mode
docker-compose up mcsrv -d

# Follow its logs
docker logs mcsrv -f

Read-Host -Prompt "Press Enter to exit"