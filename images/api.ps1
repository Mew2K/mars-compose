# Remove the existing api_server if it exists
Remove-Item -Path "/workspace/api_server" -Force

# Create a new symbolic link to the mars_api_rs
New-Item -ItemType SymbolicLink -Path "/workspace/api_server" -Target "/workspace/api/target/debug/mars_api_rs"

# List details of all files in the directory
Get-ChildItem -Path "/workspace" -Force | Format-List

# Grant execution permissions
Set-ACL -Path "/workspace/api_server" -AclObject (Get-Acl -Path "/workspace/api/target/debug/mars_api_rs")

# Execute the api_server
Start-Process "/workspace/api_server" -NoNewWindow
