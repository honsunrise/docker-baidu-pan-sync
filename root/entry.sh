#!/bin/sh
set -e

PUID=${PUID:=0}
PGID=${PGID:=0}

touch /log/cron.log
chown $PUID:$PGID /log/cron.log
touch /log/check.log
chown $PUID:$PGID /log/check.log

do_sync() {
    /check.sh
    /prepare-crontabs.sh
    crond -s /var/spool/cron/crontabs -f -L /log/cron.log "$@"
}

echo "Home dir is" ~
if [[ ! -f ~/.bypy/bypy.json || ! -f ~/.bypy/bypy.setting.json ]]; then
    echo "Please auth authorize first!"
    bypy info
    echo -e "* * * * * root /check.sh" > /etc/cron.d/sync-cron
    echo "" >> /etc/cron.d/sync-cron
    chmod 0644 /etc/cron.d/sync-cron
    do_sync
else
    do_sync
fi
