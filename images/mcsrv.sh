#!/usr/bin/env bash

cd server

# SportPaper and PGM setup
if [ ! -f "sportpaper.jar" ]; then
    wget -O sportpaper.jar https://github.com/PGMDev/PGM/releases/download/v0.15/SportPaper.jar
    mkdir plugins
    wget -O PGM.jar.zip https://nightly.link/PGMDev/PGM/workflows/build/dev/PGM.jar.zip
    unzip PGM.jar.zip
    mv PGM.jar plugins/
    rm PGM.jar.zip

    # Optional Mars build from GitHub Actions
    # wget -O Mars.zip https://nightly.link/Warzone/mars/workflows/build/pgm-0.16/Mars.zip
    # unzip Mars.zip
    # mv Mars-*SNAPSHOT*.jar plugins/
    # rm Mars.zip
fi

# Copy Mars plugin JAR from build output
cp /workspace/mars/build/libs/Mars-*-SNAPSHOT-all.jar ./plugins

# Mars config
mkdir -p ./plugins/Mars
if [ ! -f "./plugins/Mars/config.yml" ]; then
    cp /workspace/config/config.yml ./plugins/Mars/config.yml
fi

# Run the server
java -jar sportpaper.jar
