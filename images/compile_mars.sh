#!/usr/bin/env bash
if [ ! -d "mars/.git" ]; then
    git clone https://github.com/Warzone/mars.git mars
    cd mars
    git checkout -b pgm-0.16 origin/pgm-0.16
    # no achievements on the Rust API, checkout a commit without them
    git checkout 3c1ea9f275a5129fada75a697d50aeefc6340fe9
    cd ..
fi
cd mars
./gradlew --console=plain shadowJar
