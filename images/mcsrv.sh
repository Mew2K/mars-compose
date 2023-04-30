#!/usr/bin/env bash

cd /app/server
if [ ! -f "sportpaper.jar" ]; then
    wget -O sportpaper.jar https://github.com/PGMDev/PGM/releases/download/v0.15/SportPaper.jar
    mkdir plugins
    wget -O PGM.jar.zip https://nightly.link/PGMDev/PGM/actions/artifacts/668867157.zip
    unzip PGM.jar.zip
    mv PGM.jar plugins/
    rm PGM.jar.zip
    wget -O Mars.zip https://nightly.link/Warzone/mars/workflows/build/pgm-0.16/Mars.zip
    unzip Mars.zip
    mv Mars-*SNAPSHOT*.jar plugins/
    rm Mars.zip
fi
java -jar sportpaper.jar
