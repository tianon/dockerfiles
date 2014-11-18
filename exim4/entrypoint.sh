#!/bin/bash
set -e

set-exim4-update-conf dc_relay_nets "$(ip addr show dev eth0 | awk '$1 == "inet" { print $2 }')"

exec "$@"
