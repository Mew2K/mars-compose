FROM ubuntu:noble
# FROM gradle:6.6.1-jdk8
WORKDIR /workspace
RUN apt-get update
RUN apt-get install -y git openjdk-8-jdk-headless
COPY compile_mars.sh /workspace/compile_mars.sh
RUN chmod +x /workspace/compile_mars.sh
# CMD ["/usr/bin/env", "bash", "/workspace/compile_mars.sh"]
