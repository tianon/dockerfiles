#!/bin/bash
set -e

current="$(HEAD -E 'https://mms.mongodb.com/download/agent/monitoring/mongodb-mms-monitoring-agent_latest_amd64.deb' | grep '^Location:' | tail -n1 | cut -d_ -f2)"

set -x
sed -ri 's/^(ENV MMS_VERSION) .*/\1 '"$current"'/' Dockerfile
