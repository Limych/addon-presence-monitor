#!/usr/bin/with-contenv bashio
# ==============================================================================
# Limych's Hass.io Add-ons: Bluetooth Presence Monitor
# Runs some initializations for Bluetooth Presence Monitor
# ==============================================================================

readonly PREF_CONFIG_DIR="/opt/monitor"
readonly SHARE="/share/presence-monitor"

echo "${PREF_CONFIG_DIR}" >/var/run/s6/container_environment/PREF_CONFIG_DIR

declare publisher="$(bashio::config mqtt.publisher)"
if [[ -z "${publisher}" ]]; then
    publisher="hassio"
     if bashio::supervisor.ping; then
         publisher=$(bashio::host.hostname)
     elif bashio::fs.file_exists '/data/hostname'; then
        publisher=$(</data/hostname)
    fi
fi

declare certpath="$(bashio::config mqtt.certfile)"
if [[ -n "${certpath}" ]]; then
    certpath="${SHARE}/${certpath}"
fi

bashio::log.info "Updating running configuration..."

# Create share folder if it does not exist
if ! bashio::fs.directory_exists "${SHARE}"; then
    mkdir "${SHARE}"
fi

ln -s "${SHARE}/behavior_preferences" "${PREF_CONFIG_DIR}/behavior_preferences"
[[ ! -f "${SHARE}/behavior_preferences" ]] \
    && cat >"${SHARE}/behavior_preferences" <<EOF
# ---------------------------
# BEHAVIOR PREFERENCES
# ---------------------------

# MAX RETRY ATTEMPTS FOR ARRIVAL
PREF_ARRIVAL_SCAN_ATTEMPTS=1

# MAX RETRY ATTEMPTS FOR DEPART
PREF_DEPART_SCAN_ATTEMPTS=2

# SECONDS UNTIL A BEACON IS CONSIDERED EXPIRED
PREF_BEACON_EXPIRATION=240

# MINIMUM TIME BEWTEEN THE SAME TYPE OF SCAN (ARRIVE SCAN, DEPART SCAN)
PREF_MINIMUM_TIME_BETWEEN_SCANS=15

# ARRIVE TRIGGER FILTER(S)
PREF_PASS_FILTER_ADV_FLAGS_ARRIVE=".*"
PREF_PASS_FILTER_MANUFACTURER_ARRIVE=".*"

# ARRIVE TRIGGER NEGATIVE FILTER(S)
PREF_FAIL_FILTER_ADV_FLAGS_ARRIVE="NONE"
PREF_FAIL_FILTER_MANUFACTURER_ARRIVE="NONE"

# REPORT A 'home' OR 'not_home' MESSAGE TO .../device_tracker
PREF_DEVICE_TRACKER_REPORT=true

EOF

cat >"${PREF_CONFIG_DIR}/mqtt_preferences" <<EOF
# ---------------------------
# MQTT PREFERENCES
# ---------------------------

# IP ADDRESS OR HOSTNAME OF MQTT BROKER
mqtt_address='$(bashio::config mqtt.broker)'

# MQTT BROKER PORT
mqtt_port='$(bashio::config mqtt.port)'

# MQTT BROKER USERNAME
mqtt_user='$(bashio::config mqtt.username)'

# MQTT BROKER PASSWORD
mqtt_password='$(bashio::config mqtt.password)'

# MQTT PUBLISH TOPIC ROOT
mqtt_topicpath='$(bashio::config mqtt.topic_root)'

# PUBLISHER IDENTITY
mqtt_publisher_identity='${publisher}'

# MQTT CERTIFICATE FILE
mqtt_certificate_path='${certpath}'

# MQTT VERSION (EXAMPLE: 'mqttv311')
mqtt_version='$(bashio::config mqtt.version)'

EOF

cat >"${PREF_CONFIG_DIR}/address_blacklist" <<EOF
# ---------------------------
# LIST OF MAC ADDRESSES TO IGNORE, ONE PER LINE
# ---------------------------

$(bashio::config blacklist)

EOF

cat >"${PREF_CONFIG_DIR}/known_beacon_addresses" <<EOF
# ---------------------------
# BEACON MAC ADDRESS LIST; REQUIRES NAME
#   Format: 00:00:00:00:00:00 Nickname #comments
# ---------------------------

$(bashio::config known.beacons)

EOF

cat >"${PREF_CONFIG_DIR}/known_static_addresses" <<EOF
# ---------------------------
# STATIC MAC ADDRESS LIST
#   Format: 00:00:00:00:00:00 Alias #comment
# ---------------------------

$(bashio::config known.static)

EOF

if bashio::debug; then
    cat "${PREF_CONFIG_DIR}/behavior_preferences" >&2
    cat "${PREF_CONFIG_DIR}/mqtt_preferences" >&2
    cat "${PREF_CONFIG_DIR}/address_blacklist" >&2
    cat "${PREF_CONFIG_DIR}/known_static_addresses" >&2
    cat "${PREF_CONFIG_DIR}/known_beacon_addresses" >&2
fi
