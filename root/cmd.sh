#!/bin/sh

echo "Home dir is" ~

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

do_sync() {
    /home/app/check.sh >/log/check.log 2>&1
}

if [[ ! -f ~/.bypy/bypy.json || ! -f ~/.bypy/bypy.setting.json ]]; then
    echo "Please auth authorize first!"
    bypy info
    do_sync
    echo -e "* * * * * /home/app/check.sh >>/log/check.log 2>&1\n" > /etc/cron.d/sync-cron
    chmod 0644 /etc/cron.d/sync-cron
else
    do_sync
fi
