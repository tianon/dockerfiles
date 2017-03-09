#!/bin/bash
set -e

mkdir -p "$HOME/google-cloud-print-connector-config"
exec docker run -dit \
	--name google-cloud-print-connector \
	--net host \
	-v /var/run/dbus:/var/run/dbus:ro \
	-v "$HOME/google-cloud-print-connector-config":/config \
	-w /config \
	--user "$(id -u):$(id -g)" \
	tianon/google-cloud-print-connector \
	gcp-cups-connector --log-to-console
