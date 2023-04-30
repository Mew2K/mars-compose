echo 'stop' | socat EXEC:"docker attach mcserver",pty STDIN
UID_GID="$(id -u):$(id -g)" docker-compose down
