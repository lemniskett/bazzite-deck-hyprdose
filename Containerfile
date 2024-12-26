ARG SOURCE_IMAGE="bazzite"
ARG SOURCE_SUFFIX="-deck-gnome"
ARG SOURCE_TAG="testing"
FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}
COPY bin/* /usr/bin/
COPY *.service /usr/etc/systemd/system/
COPY build.sh /tmp/build.sh

RUN set -ex; \
    mkdir -p /var/lib/alternatives; \
    /tmp/build.sh; \
    ostree container commit
