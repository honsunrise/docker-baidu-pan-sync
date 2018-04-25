#!/bin/sh
set -e

echo "Check BaiduPan"
[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -xn "$0" "$0" "$@" || :

UID=`id -u`
GID=`id -g`

echo
echo "UID: $UID"
echo "GID: $GID"
echo

exec bypy syncdown / /sync False --downloader aria2 >>/log/bypy.log 2>&1

