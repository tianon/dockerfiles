#!/usr/bin/env bash
set -Eeuo pipefail

# delete stale pid file so Plex doesn't fail to start
rm -f "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/plexmediaserver.pid"

exec "$@"
