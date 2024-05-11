#!/usr/bin/env bash

# container utils
takedown_container_completely () {
    if [ ! "$(docker ps -a | grep $1)" ]; then
        return
    fi
    if [ "$( docker container inspect -f '{{.State.Running}}' $1 )" == "true" ]; then
        docker stop $1
    fi
    if [ "$( docker container inspect -f '{{.State.Running}}' $1 )" == "false" ]; then
        docker rm $1
    fi
}

takedown_container_completely "mars_compile"
