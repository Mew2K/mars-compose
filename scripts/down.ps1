function container-is-running {
    param($containerName)
    $container = docker ps -a | Select-String $containerName
    if (!$container) {
        return 0
    }
    $running = docker container inspect -f '{{.State.Running}}' $containerName
    if ($running -eq "true") {
        return 1
    } else {
        return 0
    }
}

# Send stop to the MC server
$mcsrvContainer = "mcsrv"
if ((container-is-running $mcsrvContainer) -eq 1) {
    echo "stop" | docker attach $mcsrvContainer
    Start-Sleep -Seconds 1
    # if it didn't exit kill it
    if ((container-is-running $mcsrvContainer) -eq 1) {
        docker kill $mcsrvContainer
    }
}

# Send SIGINT to the API
$apiContainer = "api"
if (docker ps -aq -f name=^$apiContainer$) {
    docker stop --signal SIGINT --time 3 $apiContainer
}

# Stop the rest (redis, mongo)
if (docker ps -aq -f name=^mongo$) {
    docker stop mongo
    docker rm mongo
}
if (docker ps -aq -f name=^redis$) {
    docker stop redis
    docker rm redis
}

# Remove the others
if (docker ps -aq -f name=^$apiContainer$) {
    docker rm $apiContainer
}
if (docker ps -aq -f name=^$mcsrvContainer$) {
    docker rm $mcsrvContainer
}

$apiCompileContainer = "api_compile"
if (docker ps -aq -f name=^$apiCompileContainer$) {
    docker rm $apiCompileContainer
}

# Exit clean to disregard last status
exit 0