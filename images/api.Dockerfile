FROM rust:latest
WORKDIR /app/server
COPY mcsrv.sh /app/mcsrv.sh
COPY mars-0.15-fixes.patch /app/mars-0.15-fixes.patch
RUN chmod +x /app/mcsrv.sh
CMD ["/usr/bin/env", "bash", "/app/mcsrv.sh"]
