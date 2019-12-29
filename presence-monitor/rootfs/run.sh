#!/usr/bin/with-contenv bashio
# ==============================================================================
# Limych's Hass.io Add-ons: Bluetooth Presence Monitor
# Run Bluetooth Presence Monitor
# ==============================================================================

declare -a options



bashio::log.info "Starting required services..."

cleanup() {
    bashio::log.info "Finishing services..."

    service bluetooth stop
    service dbus stop

    exec echo
}

trap "cleanup" EXIT INT TERM

service dbus start
service bluetooth start



bashio::log.info "Starting Bluetooth Presence Monitor..."

# Find the matching Bluetooth Presence Monitor log level
if bashio::config.has_value 'log_level'; then
    case "$(bashio::string.lower "$(bashio::config 'log_level')")" in
        all|trace|debug)
            options+=(-V)
            ;;
    esac
fi

monitor "${options[@]}" "${@}" >&2
exit $?
