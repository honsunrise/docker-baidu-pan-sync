#!/bin/sh
set -e

echo "Home dir is" ~

touch /log/cron.log
touch /log/check.log

do_sync() {
    /home/app/check.sh
    /home/app/prepare-crontabs.sh
    crond -s /var/spool/cron/crontabs -f -L /log/cron.log "$@"
}

if [[ ! -f ~/.bypy/bypy.json || ! -f ~/.bypy/bypy.setting.json ]]; then
    echo "Please auth authorize first!"
    bypy info
    echo -e "* * * * * app /home/app/check.sh\n" > /etc/cron.d/sync-cron
    chmod 0644 /etc/cron.d/sync-cron
    do_sync
else
    do_sync
fi
