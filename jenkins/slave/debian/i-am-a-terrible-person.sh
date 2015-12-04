#!/bin/sh
set -e

# start SSHd in the background, like the horrible people we are
mkdir -p /var/run/sshd
/usr/sbin/sshd -D &

exec dockerd-entrypoint.sh "$@"
