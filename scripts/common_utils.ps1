# common_utils.ps1

function ContainerExists {
    param([string]$name)
    $exists = docker ps -aq -f "name=^$name$"
    if ($exists) {
        return 1
    } else {
        return 0
    }
}

function ContainerIsRunning {
    param([string]$name)
    $info = docker ps -a | Select-String $name
    if (-not $info) {
        return 0
    }

    $isRunning = docker container inspect -f '{{.State.Running}}' $name
    if ($isRunning -eq "true") {
        return 1
    } else {
        return 0
    }
}

function Kill-MCServer {
    $mcsrv_container = "mcsrv"
    if ((ContainerIsRunning $mcsrv_container) -eq 1) {
        # Send "stop" to the MC server
        echo "stop" | socat.exe EXEC:"docker attach $mcsrv_container",pty STDIN

        $sleeper = Start-Job { Start-Sleep -Seconds 5 }
        $waiter = Start-Job { docker wait $using:mcsrv_container }

        # Wait for either job to finish first
        while ($true) {
            if ((Get-Job -Id $sleeper.Id).State -eq 'Completed' -or (Get-Job -Id $waiter.Id).State -eq 'Completed') {
                break
            }
            Start-Sleep -Milliseconds 250
        }

        Remove-Job -Id $sleeper.Id, $waiter.Id

        if ((ContainerIsRunning $mcsrv_container) -eq 1) {
            docker kill $mcsrv_container
        }
    }
}

function Compile-Plugin {
    if (-not (Test-Path "mars")) {
        New-Item -ItemType Directory -Path "mars" | Out-Null
    }

    docker-compose up mars_compile -d
    docker exec mars_compile './compile_mars.sh'
}

Read-Host -Prompt "Press Enter to exit"