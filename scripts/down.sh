#!/usr/bin/env bash
# container utils
container_is_running () {
    if [ ! "$(docker ps -a | grep $1)" ]; then
        echo 0
        return
    fi
    if [ "$( docker container inspect -f '{{.State.Running}}' $1 )" == "true" ]; then
        echo 1
    else
        echo 0
    fi
}

# send stop to the MC server
mcsrv_container="mcsrv"
if [ $(container_is_running "${mcsrv_container}") -eq 1 ]; then
    echo "stop" | socat EXEC:"docker attach ${mcsrv_container}",pty STDIN
    sleep 1
    # if it didnt exit kill it
    if [ $(container_is_running "${mcsrv_container}") -eq 1 ]; then
        docker kill ${mcsrv_container}
    fi
fi
# send SIGINT to the API
api_container="api"
[ "$(docker ps -aq -f name=^${api_container}$)" ] && docker stop --signal=SIGINT --time 3 ${api_container}
# stop the rest (redis, mongo)
if [ "$(docker ps -aq -f name=^mongo$)" ]; then
    docker stop mongo
    docker rm mongo
fi
if [ "$(docker ps -aq -f name=^redis$)" ]; then
    docker stop redis
    docker rm redis
fi
# rm the others
[ "$(docker ps -aq -f name=^${api_container}$)" ] && docker rm ${api_container}
[ "$(docker ps -aq -f name=^${mcsrv_container}$)" ] && docker rm ${mcsrv_container}

api_compile_container="api_compile"
[ "$(docker ps -aq -f name=^${api_compile_container}$)" ] && docker rm ${api_compile_container}
# exit clean to disregard last status
exit 0
