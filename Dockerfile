FROM hypriot/rpi-alpine-scratch

RUN apk update && \
apk add transmission-daemon

RUN rm -rf /var/cache/apk/*
RUN (crontab -l 2>/dev/null; echo "*/5 * * * * find /blackhole -name '*.torrent'-type f -exec touch \{} +") | crontab -

VOLUME /unsorted /incomplete /config /blackhole

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp

CMD ["/usr/bin/transmission-daemon", "-f", "-g", "/config"]
