#
# Multi stage build of add-on container
#

ARG BUILD_FROM=debian:stretch-slim
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
ARG BUILD_ARCH=amd64
RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        bluetooth \
        bluez \
        bluez-hcidump \
        bc \
        usbutils \
        git \
        curl \
        ca-certificates \
        mosquitto-clients \
    && git clone https://github.com/andrewjfreyer/monitor.git /monitor

# Copy root filesystem
COPY rootfs /

ENTRYPOINT ["/run.sh"]

WORKDIR /monitor
CMD ["/bin/bash", "monitor.sh", "-D", "/config"]

#
# LABEL target docker image
#

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Bluetooth Presence Monitor" \
    io.hass.description="Passive Bluetooth presence detection of beacons, cell phones, and other Bluetooth devices." \
    io.hass.arch="aarch64|amd64|armhf|armv7|i386" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Andrey Khrolenok <andrey@khrolenok.ru>" \
    org.label-schema.description="Passive Bluetooth presence detection of beacons, cell phones, and other Bluetooth devices." \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Bluetooth Presence Monitor" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://github.com/Limych/hassio-addons/presence-monitor" \
    org.label-schema.usage="https://github.com/Limych/hassio-addons/presence-monitor/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/Limych/hassio-addons/presence-monitor" \
    org.label-schema.vendor="Limych's Hass.io Addons"
