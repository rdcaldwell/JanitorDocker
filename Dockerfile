FROM openjdk:8-alpine

ENV CONFD_VERSION      0.13.0

WORKDIR /simianarmy

RUN apk update \
    && apk upgrade \
    && apk add bash curl git \
    && git clone https://github.com/rdcaldwell/SimianArmy.git . \
    && ./gradlew build --no-daemon \
    && curl -fsSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /usr/local/bin/confd \
    && chmod +x /usr/local/bin/confd

COPY confd/ /etc/confd

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080 8081
