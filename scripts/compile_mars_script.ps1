# compile_mars_script.ps1

# Import functions from common_utils.ps1
. "$PSScriptRoot\common_utils.ps1"

# Set UID:GID environment variable (optional on Windows, adjust as needed)
$uid = $(id -u)
$gid = $(id -g)
$env:UID_GID = "$uid`:$gid"

# Call the compile_plugin function
Compile-Plugin

Read-Host -Prompt "Press Enter to exit"