FROM openjdk:8
WORKDIR /workspace
RUN apt-get update
RUN apt-get install -y wget git unzip
EXPOSE 25565
COPY mcsrv.sh /workspace/mcsrv.sh
RUN chmod +x /workspace/mcsrv.sh
CMD ["/usr/bin/env", "bash", "/workspace/mcsrv.sh"]
