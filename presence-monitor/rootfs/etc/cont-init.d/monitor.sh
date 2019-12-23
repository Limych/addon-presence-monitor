#!/usr/bin/env bashio
# ==============================================================================
# Limych's Hass.io Add-ons: Bluetooth Presence Monitor
# Runs some initializations for Bluetooth Presence Monitor
# ==============================================================================

if bashio::debug; then
    set -x
fi

bashio::require.unprotected

cleanup() {
    if [[ $pid -gt 0 ]]; then
        kill $pid
    fi
    service bluetooth stop
    service dbus stop
    exec echo
}

trap "cleanup" EXIT INT TERM

service dbus start
service bluetooth start

bashio::log.info "Create Bluetooth Presence Monitor config files..."

## address_blacklist
cat >"/config/address_blacklist" <<EOF
# LIST OF MAC ADDRESSES TO IGNORE, ONE PER LINE:
$(bashio::config blacklist)
EOF

cat "/config/address_blacklist" >&2

## known_beacon_addresses
cat >"/config/known_beacon_addresses" <<EOF
# ---------------------------
#
# BEACON MAC ADDRESS LIST; REQUIRES NAME
#
#   Format: 00:00:00:00:00:00 Nickname #comments
# ---------------------------
$(bashio::config known.beacons)
EOF

cat "/config/known_beacon_addresses" >&2

## known_static_addresses
cat >"/config/known_static_addresses" <<EOF
# ---------------------------
#
# STATIC MAC ADDRESS LIST
#
#   Format: 00:00:00:00:00:00 Alias #comment
# ---------------------------
$(bashio::config known.static)
EOF

cat "/config/known_static_addresses" >&2

## known_static_addresses
cat >"/config/mqtt_preferences" <<EOF
# ---------------------------
#                               
# MQTT PREFERENCES
#                               
# ---------------------------

# IP ADDRESS OR HOSTNAME OF MQTT BROKER
mqtt_address="$(bashio::config mqtt.broker)"

# MQTT BROKER PORT 
mqtt_port="$(bashio::config mqtt.port)"

# MQTT BROKER USERNAME
mqtt_user="$(bashio::config mqtt.username)"

# MQTT BROKER PASSWORD
mqtt_password="$(bashio::config mqtt.password)"

# MQTT PUBLISH TOPIC ROOT 
mqtt_topicpath="$(bashio::config mqtt.topic_root)"

# PUBLISHER IDENTITY 
mqtt_publisher_identity="$(bashio::config mqtt.publisher)"

# MQTT CERTIFICATE FILE
mqtt_certificate_path="$(bashio::config mqtt.certfile)"

# MQTT VERSION (EXAMPLE: 'mqttv311')
mqtt_version="$(bashio::config mqtt.version)"
EOF

cat "/config/mqtt_preferences" >&2
exit

# write out the timestamp of the last msg received
date +%s > last_msg
while true; do [[ -e main_pipe ]] && read line < main_pipe && date +%s > last_msg; done &

bashio::log.info "Starting Bluetooth Presence Monitor server..."

monitor "${@}"
exit $?
