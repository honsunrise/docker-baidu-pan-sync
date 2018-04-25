#!/bin/sh
set -e
echo "Check BaiduPan"
[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -xn "$0" "$0" "$@" || :
bypy syncdown / /sync False --downloader aria2 >>/log/bypy.log 2>&1

