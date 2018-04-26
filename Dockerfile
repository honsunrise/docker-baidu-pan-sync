FROM alpine
MAINTAINER zhsyourai<mysoftzhs@gmail.com>

RUN apk update
RUN apk add python python-dev py-pip build-base
RUN apk add aria2 shadow
RUN apk add dcron wget rsync ca-certificates
RUN pip install requests multiprocess
RUN pip install bypy
RUN rm -rf /var/cache/apk/*

RUN mkdir -p /home/app
RUN addgroup -S app && adduser -s /bin/sh -S -G app -h /home/app app
RUN chown app:app /home/app

RUN mkdir -p /var/spool/cron/crontabs && chown app:app /var/spool/cron/crontabs
RUN mkdir -p /etc/cron.d && chown app:app /etc/cron.d

COPY root/ /home/app/
RUN chown -R app:app /home/app/

VOLUME /sync
VOLUME /log

ENTRYPOINT ["/home/app/entry.sh"]
CMD ["/home/app/cmd.sh"]
