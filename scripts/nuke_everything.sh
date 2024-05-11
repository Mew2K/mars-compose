rm -rf server api mars
./scripts/mars_compile_daemon_kill.sh
docker volume rm mars-compose-dev_mars-api
