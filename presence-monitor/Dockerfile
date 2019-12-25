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
    && git clone --branch "master" --depth=1 https://github.com/andrewjfreyer/monitor.git /monitor

# Copy root filesystem
COPY rootfs /

# Configure system
ARG PREF_CONFIG_DIR=/opt/monitor
RUN install -d \
        ${PREF_CONFIG_DIR} \
    && sed -i "s|PREF_CONFIG_DIR=.*|PREF_CONFIG_DIR=\"${PREF_CONFIG_DIR}\"|" /etc/cont-init.d/monitor-configs.sh \
    \
    && cd /monitor \
    && touch \
        .pids \
        .previous_version \
        ${PREF_CONFIG_DIR}/.public_name_cache \
    # make things executable
    && ln -s /monitor/monitor.sh /usr/local/bin/monitor \
    && chmod a+x \
        monitor.sh \
        /run.sh \
    # link the public name cache to the config directory ... i think there's a bug in monitor.sh where it doesn't consistently reference the same path to this...sometimes it looks in $base_directory (which we have as ${PREF_CONFIG_DIR}) and sometimes its in the app root (i.e. /monitor)
    && ln -s ${PREF_CONFIG_DIR}/.public_name_cache .public_name_cache \
    # no systemctl ... this keeps the error out about it
    && sed -i "s|systemctl is-active.*|SERVICE_ACTIVE=false|" support/init \
    # default config directory to come from an environment variable
    && sed -i "s|PREF_CONFIG_DIR=.*|PREF_CONFIG_DIR=\"${PREF_CONFIG_DIR}\"|" support/argv

WORKDIR /monitor

CMD /run.sh

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
