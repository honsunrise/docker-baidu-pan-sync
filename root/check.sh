#!/bin/sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

echo "Check BaiduPan"
[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -xn "$0" "$0" "$@" || :

if [ $(whoami) == "root" ]; then
   /bin/su -c "exec bypy --processes 5 --downloader aria2 --downloader-arguments=\"-d \\\"/sync\\\"\" -v syncdown / \"\" False >>/log/bypy.log 2>&1" - app
else
   exec bypy --processes 5 --downloader aria2 --downloader-arguments="-d \"/sync\"" -v syncdown / "" False >>/log/bypy.log 2>&1
fi
