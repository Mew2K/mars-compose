# Mars API Docker compose configuration

## Description

Docker compose configuration for a Mars server. Provides default configuration options.

This setup is not intended for development environments. Use only for running.

Includes:
- [MongoDB image](https://hub.docker.com/_/mongo)
- [Redis image](https://hub.docker.com/_/redis)
- [Nginx image](https://hub.docker.com/_/nginx)
- [Mars API RS image](https://github.com/chatasma/mars-api-rs/pkgs/container/mars-api-rs)
- SportPaper image (locally defined)

## Instructions

First, you will need Docker installed and the user you execute the startup script to be added to the `docker` group.

- Startup:

```sh
./scripts/up.sh
```

- Teardown:

```sh
./scripts/down.sh
```

## Notes

- The Mars API RS image is only built for `linux/amd64`. Consequently, the host must be AMD64 as well.
- Don't try setting a password for Redis.. the API does not authenticate with one
- Host-mapped ports include 8000 for the HTTP API and 25565 for the MC server
