#
# Multi stage build of add-on container
#

ARG BUILD_FROM=hassioaddons/base:5.0.3
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG BUILD_ARCH=amd64
RUN apk add --no-cache \
        bluez \
        bluez-btmon \
        bluez-deprecated \
        dbus \
        git \
        mosquitto-clients \
    && git clone --depth=1 https://github.com/andrewjfreyer/monitor.git /monitor

# Copy root filesystem
COPY rootfs /

WORKDIR /monitor

RUN touch .pids
RUN touch .previous_version
    # make things executable
RUN ln -s /monitor/monitor.sh /usr/local/bin/monitor
RUN chmod a+x monitor.sh
RUN touch /config/.public_name_cache
    # link the public name cache to the config directory ... i think there's a bug in monitor.sh where it doesn't consistently reference the same path to this...sometimes it looks in $base_directory (which we have as /config) and sometimes its in the app root (i.e. /monitor)
RUN ln -s /config/.public_name_cache .public_name_cache
    # no systemctl ... this keeps the error out about it
RUN sed -i 's|systemctl is-active.*|SERVICE_ACTIVE=false|' support/init
    # default config directory to come from an environment variable
RUN sed -i 's|PREF_CONFIG_DIR='"''"'|PREF_CONFIG_DIR="/config"|' support/argv

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
