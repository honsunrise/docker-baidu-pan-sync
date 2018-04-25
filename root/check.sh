#!/bin/sh
set -e

echo "Check BaiduPan"
[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -xn "$0" "$0" "$@" || :

PUID=${PUID:=0}
PGID=${PGID:=0}

exec s6-setuidgid $PUID:$PGID bypy syncdown / /sync False --downloader aria2 >>/log/bypy.log 2>&1

