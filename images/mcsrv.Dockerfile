FROM openjdk:8
WORKDIR /app/server
RUN apt-get update
RUN apt-get install -y wget git unzip
EXPOSE 25565
COPY mcsrv.sh /app/mcsrv.sh
COPY mars-0.15-fixes.patch /app/mars-0.15-fixes.patch
RUN chmod +x /app/mcsrv.sh
CMD ["/usr/bin/env", "bash", "/app/mcsrv.sh"]
