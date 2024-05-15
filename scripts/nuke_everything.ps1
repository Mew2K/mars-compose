Remove-Item -Path server, api, mars -Recurse -Force
& "./scripts/mars_compile_daemon_kill.ps1"
docker volume rm mars-compose-dev_mars-api