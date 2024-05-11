FROM ubuntu:noble
WORKDIR /workspace
COPY api.sh /workspace/api.sh
RUN chmod +x /workspace/api.sh
ENTRYPOINT ["/usr/bin/env", "bash", "/workspace/api.sh"]
