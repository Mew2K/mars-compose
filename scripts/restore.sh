#!/bin/sh

location=$0
file="$(basename "$location")"
locContainer="/backup/$(basename "$location")"

sudo docker run --rm -v mars-api-compose_mars-api:/data -v "$0":"/backup/$(basename "$0")" busybox tar -xvzf "/backup/$(basename "$0")" /data

# sudo docker run --rm -v mars-api-compose_mars-api:/data -v "$(pwd)"/backup/backup.tar:/backup/backup.tar busybox tar -xvzf "/backup/backup.tar" -C / data