function takedown-container-completely {
    param($containerName)
    $container = docker ps -a | Select-String $containerName
    if (!$container) {
        return
    }
    $running = docker container inspect -f '{{.State.Running}}' $containerName
    if ($running -eq "true") {
        docker stop $containerName
    }
    $running = docker container inspect -f '{{.State.Running}}' $containerName
    if ($running -eq "false") {
        docker rm $containerName
    }
}

takedown-container-completely "mars_compile"
