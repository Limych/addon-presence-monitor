ARG BUILD_FROM=hassioaddons/debian-base:latest
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Install required packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bc \
        bluetooth \
        bluez \
        bluez-hcidump \
        git \
        mosquitto-clients \
        procps \
        usbutils \
    && git clone --branch "master" --depth=1 https://github.com/andrewjfreyer/monitor.git /monitor \
    && cd /monitor \
    && git checkout origin/master -f

# Copy root filesystem
COPY rootfs /

# Configure system
RUN install -d /opt/monitor \
    && touch \
        /monitor/.pids \
        /monitor/.previous_version \
        /opt/monitor/.public_name_cache \
    # link the public name cache to the config directory ... i think there's a bug in monitor.sh
    # where it doesn't consistently reference the same path to this... sometimes it looks in
    # $base_directory (which we have as /opt/monitor) and sometimes its in the app root (i.e. /monitor)
    && ln -s /opt/monitor/.public_name_cache /monitor/.public_name_cache \
    # make things executable
    && chmod +x /*.sh \
    && ln -s /monitor/monitor.sh /usr/local/bin/monitor

WORKDIR /monitor

HEALTHCHECK CMD [ "/health.sh" ]

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
    org.label-schema.url="https://github.com/Limych/hassio-addons/tree/master/presence-monitor" \
    org.label-schema.usage="https://github.com/Limych/hassio-addons/presence-monitor/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/Limych/hassio-addons/tree/master/presence-monitor" \
    org.label-schema.vendor="Limych's Hass.io Addons"
