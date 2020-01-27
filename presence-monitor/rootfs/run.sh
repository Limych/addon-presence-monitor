#!/usr/bin/with-contenv bashio
# ==============================================================================
# Limych's Hass.io Add-ons: Bluetooth Presence Monitor
# Run Bluetooth Presence Monitor
# ==============================================================================

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



bashio::log.info "Updating Bluetooth Presence Monitor to latest version..."

git fetch --depth=1 \
    && git checkout -f \
    && git pull -f



bashio::log.info "Starting Bluetooth Presence Monitor..."

# write out the timestamp of the last msg received
date +%s > last_msg
while true; do [[ -e main_pipe ]] && read line < main_pipe && date +%s > last_msg; done &

declare -a args

# Find the matching Bluetooth Presence Monitor log level
if bashio::config.has_value 'log_level'; then
    case "$(bashio::string.lower "$(bashio::config 'log_level')")" in
        all|trace|debug)
            args+=(-V)
            ;;
    esac
fi

if bashio::config.has_value 'known.beacons'; then
    args+=(-b)
fi

while monitor -D /opt/monitor ${args[@]} $(bashio::config 'extra_arguments') >&2; do
    bashio::log.info "Restarting Bluetooth Presence Monitor..."
done
exit $?
