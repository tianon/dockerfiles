#!/bin/sh
set -eu

# "A connector is already running, or the monitoring socket /tmp/cloud-print-connector-monitor.sock wasn't cleaned up properly"
rm -f /tmp/cloud-print-connector-monitor.sock

exec "$@"
