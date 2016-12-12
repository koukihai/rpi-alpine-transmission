# rpi-alpine-transmission

[Transmission](https://transmissionbt.com) is a cross-platform BitTorrent client that is:
  - OpenSource
  - Easy
  - Lean
  - Native
  - Powerful

# Summary
This image is designed to run Transmission on Raspberry Pi.  
It is based on Alpine Linux to make it as lightweight as possible.  

# Usage
```
docker run -d --name transmission \
  -v /etc/localtime:/etc/localtime:ro \
  -v /media/conf/transmission:/config \
  -v /media/Unsorted:/unsorted \
  -v /media/incomplete:/incomplete \
  -v /media/blackhole:/blackhole \
  -p 9091:9091 \
  -p 51413:51413/udp \
  -p 51413:51413/tcp \
  koukihai/rpi-alpine-transmission
```
where:  
`/media/conf/transmission` is the folder on the host where you will store transmission configurations  
`/media/Unsorted` is the folder on the host where you will store completed downloads
`/media/incomplete` is the folder on the host where you will store incomplete files  
`/media/blackhole` is... just in case you need to plug a blackhole listener  

# Details
Transmission daemon will run as `transmission:users`  
Ensure that the `users` group has write permissions on the mapped volumes

# Credits
https://hub.docker.com/r/robsharp/rpi-transmission/  


