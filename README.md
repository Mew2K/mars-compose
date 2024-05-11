# (Mars API RS + Mars) Development Docker compose configuration

## Description

**Development** docker compose configuration for a Mars server with `mars-api-rs`.

This setup is not intended for production environments. Use only for development.

## Requirements and Prerequisites

* `docker-compose`, `docker`, `socat` need to be on your system
  * Linux only for now (scripts are Bash, `socat`, container user setup)
  * Install from your distribution's repositories
  * Add your user to the `docker` group
* Make sure the `docker` service on your system is running

## Instructions

- Startup:

```sh
./scripts/up.sh
```

* Compiles the Rust API and plugin
  * API is compiled on bind-mount `./api` by starting a one-shot container to compile it and exit
  * Plugin is compiled on bind-mount `./mars` by executing the compilation command to a long-running container
    * The plugin compilation container is kept around to persist the Gradle daemon for incremental builds
* Starts up MongoDB, Redis, the API, and a SportPaper server with the compiled plugin
  * The configs are defined in `./config` which get bind-mounted into the appropriate container
  * `./config/mars/config.yml` is only used for the initial Mars configuration, i.e. on the first run when there is no config/server defined yet
  * SportPaper server starts on the `./server` bind mount
    * Subsequent Mars configuration needs to be done directly on `./server/plugins/Mars/config.yml` if it exists

- Teardown (not including Gradle daemon):

```sh
./scripts/down.sh
```

* `/stop`s the server if running
* Sends a `SIGINT` to the API
  * or kills it if it does not exit after 3 seconds
* Stops Redis/Mongo
* Removes the appropriate containers

As the plugin source and API source are checked out to the `./mars` and `./api` bind mounts respectively, development can be done by making changes to the sources, tearing down, and starting up again.

- Killing plugin Gradle daemon:

```sh
./scripts/mars_compile_daemon_kill.sh
```

* Stops and removes the plugin compilation container

## Notes

- Don't try setting a password for Redis.. the API does not authenticate with one
- Changing the ports may require changing the compose file as the ports are pretty much hardcoded in there right now
- Default host-mapped ports include 8000 for the HTTP API and 25565 for the MC server
