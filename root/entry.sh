#!/bin/sh
set -e

PUID=${PUID:=0}
PGID=${PGID:=0}

echo "PUID: " $PUID
echo "PGID: " $PGID

groupmod -g $PGID app
usermod -u $PUID -g $PGID app

chown -R $PUID:$PGID /var/spool/cron/crontabs
chown -R $PUID:$PGID /etc/cron.d
chown -R $PUID:$PGID /log
chown -R $PUID:$PGID /sync
chown -R $PUID:$PGID /home/app

echo "Modiby user success"
/bin/su -c "$@" - app
