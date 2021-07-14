FROM alpine

RUN apk update --no-cache && \
    apk add docker-compose curl
