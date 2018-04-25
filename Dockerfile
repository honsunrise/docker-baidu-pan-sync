FROM alpine
MAINTAINER zhsyourai<mysoftzhs@gmail.com>

COPY root/ /

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 LC_ALL=en_US.UTF-8

RUN apk update
RUN apk add python python-dev py-pip build-base
RUN apk add aria2 s6
RUN apk add dcron wget rsync ca-certificates
RUN pip install requests
RUN pip install bypy
RUN rm -rf /var/cache/apk/*
RUN mkdir -m 0644 -p /var/spool/cron/crontabs && mkdir -m 0644 -p /etc/cron.d

VOLUME /sync
VOLUME /log
VOLUME /config

ENTRYPOINT ["/entry.sh"]
