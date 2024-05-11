#!/usr/bin/env bash
if [ ! -d "api/.git" ]; then
    git clone https://github.com/Warzone/mars-api-rs.git api
fi
cd api
cargo build
