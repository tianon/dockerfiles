#!/bin/sh
set -e

# start SSHd in the background, like the horrible people we are
/etc/init.d/ssh start

exec dockerd-entrypoint.sh "$@"
