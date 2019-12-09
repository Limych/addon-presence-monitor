#!/bin/bash

set -e

service dbus start
service bluetooth start
hciconfig hci0 up

exec "$@"
