#!/usr/bin/with-contenv bashio
# ==============================================================================
# Limych's Hass.io Add-ons: Bluetooth Presence Monitor
# Check Bluetooth Presence Monitor for health
# ==============================================================================

MAX_MSG_DELAY=${PREF_LAST_MSG_DELAY:-300}
LAST_ACTIVITY=$(cat last_msg)
ELAPSED=$(echo "$(date +"%s") - ${LAST_ACTIVITY}"|bc)

bashio::log.debug "Time since last message: ${ELAPSED} seconds"

[[ ${ELAPSED} -gt ${MAX_MSG_DELAY} ]] && bashio::exit.nok "Monitor seems died. Need restarting."
