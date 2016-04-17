FROM hypriot/rpi-alpine-scratch

# Install transmission
RUN apk update && \
apk add transmission-daemon

# Remove cache
RUN rm -rf /var/cache/apk/*

# Create user transmission and add it to the "users" group
# Usage: adduser [OPTIONS] USER [GROUP]
#
# Create new user, or add USER to GROUP
#
#	-h DIR		Home directory
#	-g GECOS	GECOS field
#	-s SHELL	Login shell
#	-G GRP		Add user to existing group
#	-S		Create a system user
#	-D		Don't assign a password
#	-H		Don't create home directory
#	-u UID		User id
RUN id transmission || adduser -S -s /bin/false -H -D transmission
RUN addgroup transmission users 

RUN mkdir -p /unsorted /incomplete /config /blackhole && \
    chmod 775 /unsorted /incomplete /config /blackhole && \
    chgrp -R users /unsorted /blackhole
RUN chown -R transmission:users /incomplete /config

# Continue as user 'transmission'
USER transmission

# Expose volumes:
# - Unsorted for completed downloads to be sorted
# - Incomplete for ongoing downloads
# - Config for configuration files
# - Blackhole to trigger downloads when a torrent is added 
# [Note: Blackhole doesnt seem to work if the torrent has been added by another host, through an NFS share for example]
VOLUME /unsorted /incomplete /config /blackhole

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp

CMD ["/usr/bin/transmission-daemon", "-f", "-g", "/config"]
