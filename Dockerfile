# syntax=docker/dockerfile:1


FROM alpine:latest

ARG DEWEB_VERSION="v0.4.0"
ARG DEWEB_BINARY="deweb-server_linux_amd64"

LABEL maintainer="github.com/dex2code"
LABEL description="MASSA DEWEB server"
LABEL version=${DEWEB_VERSION}

ARG APP_UID=5000
ARG APP_USER="massa"
ARG APP_GID=5000
ARG APP_GROUP="massa"

RUN apk update && \
    apk add --no-cache gcompat libstdc++ && \
    apk cache purge

RUN addgroup -g ${APP_GID} ${APP_GROUP} && \
    adduser -s /bin/false -G ${APP_GROUP} -D -u ${APP_UID} ${APP_USER}

ADD --chown=${APP_USER}:${APP_GROUP} --chmod=755 \
    https://github.com/massalabs/DeWeb/releases/download/${DEWEB_VERSION}/${DEWEB_BINARY} /home/${APP_USER}/deweb-server

COPY --chown=${APP_USER}:${APP_GROUP} --chmod=644 \
     deweb_server_config.yaml /home/${APP_USER}/deweb_server_config.yaml

USER ${APP_USER}
WORKDIR /home/${APP_USER}
EXPOSE 8080

RUN ln -s /dev/null /home/${APP_USER}/deweb-server.log
RUN mkdir -p /home/${APP_USER}/websitesCache

VOLUME /home/${APP_USER}/websitesCache

CMD ["/home/massa/deweb-server"]
