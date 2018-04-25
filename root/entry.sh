#!/bin/sh
set -e

mkdir -p /log/cron
touch /log/cron/cron.log

do_sync() {
    /check.sh
    /prepare-crontabs.sh
    crond -s /var/spool/cron/crontabs -f -L /log/cron/cron.log "$@"
}

echo "Home dir is" ~
if [[ ! -f ~/.bypy/bypy.json || ! -f ~/.bypy/bypy.setting.json ]]; then
    echo "Please auth authorize first!"
    bypy info
    echo "*/1 * * * * /check.sh" > /etc/cron.d/sync-cron
    echo "" >> /etc/cron.d/sync-cron
    chmod 0644 /etc/cron.d/sync-cron
    do_sync
else
    echo "Check BaiduPan"
    do_sync
fi
