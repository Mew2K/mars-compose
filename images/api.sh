#!/usr/bin/env bash
rm -f /workspace/api_server
ln -s /workspace/api/target/debug/mars_api_rs /workspace/api_server
ls -la
chmod +x /workspace/api_server
exec ./api_server
