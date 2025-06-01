FROM amazoncorretto:17-alpine-jdk
# FROM gradle:6.6.1-jdk8
WORKDIR /workspace
RUN apk update
RUN apk add git bash curl wget maven
COPY compile_mars.sh /workspace/compile_mars.sh
RUN chmod +x /workspace/compile_mars.sh
CMD ["/usr/bin/env", "bash", "/workspace/compile_mars.sh"]
