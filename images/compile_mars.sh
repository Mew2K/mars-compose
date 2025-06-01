#!/usr/bin/env bash

echo "[compile_mars.sh] Starting Mars compilation script"

if [ ! -d "mars/.git" ]; then
    echo "MARS GIT NOT FOUND. CLONING!!!"
    git clone https://github.com/Warzone/mars.git mars
fi

cd mars

sed -i 's/\r$//' gradlew

java -version

echo "Compiling..."


# ./gradlew clean build --no-daemon
./gradlew --console=plain shadowJar

# exec /bin/sh