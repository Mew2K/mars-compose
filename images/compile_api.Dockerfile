FROM rust:latest
WORKDIR /workspace
COPY compile_api.sh /workspace/compile_api.sh
RUN chmod +x /workspace/compile_api.sh
CMD ["/usr/bin/env", "bash", "/workspace/compile_api.sh"]
