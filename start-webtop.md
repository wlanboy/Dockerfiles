# Start webtop instance

Ubuntu-Desktop im Browser — kein VNC-Client nötig, Zugriff direkt über http://127.0.0.1:3000

```bash
docker run -d \
  --name=webtop \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Berlin \
  -e SUBFOLDER=/ \
  -e KEYBOARD=de-de-qwertz\
  -e TITLE=Webtop \
  -p 3000:3000 \
  -v /home/samuel/desk:/config \
  --shm-size="2gb" \
  lscr.io/linuxserver/webtop:ubuntu-mate
```

## access instance

Browser-URL zum Öffnen des Desktop-Clients.

* http://127.0.0.1:3000/

## find other versions

Weitere verfügbare Desktop-Umgebungen (KDE, XFCE, etc.) und Architekturen in der offiziellen Doku.

* https://docs.linuxserver.io/images/docker-webtop/#version-tags
