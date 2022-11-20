# Start webtop instance

```
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
# access instance
* http://127.0.0.1:3000/
