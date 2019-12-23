#!/usr/bin/env bashio
# ==============================================================================
# Limych's Hass.io Add-ons: Bluetooth Presence Monitor
# Ensures we've got an unique D-Bus ID
# ==============================================================================

dbus-uuidgen --ensure \
  || bashio::exit.nok 'Failed to generate a unique D-Bus ID'
