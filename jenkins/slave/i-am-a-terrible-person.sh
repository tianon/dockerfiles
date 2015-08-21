#!/bin/sh
set -e

# start SSHd in the background, like the horrible people we are
/usr/sbin/sshd -D &

exec dockerd-entrypoint.sh "$@"
