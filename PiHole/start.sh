export MYIP=192.168.0.10
export DNS1=192.168.0.1
export DNS2=8.8.8.8

mkdir -p ~/pihole/{etc,dns}

docker run -d --name pihole \
    -p 8080:80 -p $MYIP:53:53/tcp -p $MYIP:53:53/udp -p 67:67/udp \
    -v ./pihole/etc/:/etc/pihole/ \
    -v ./pihole/dns:/etc/dnsmasq.d/ \
    -e TZ=Europe/Berlin \
    -e ServerIP=$MYIP \
    -e WEBPASSWORD=pihole \
    -e DNS1=$DNS1 \
    -e DNS2=$DNS2 \
    --restart unless-stopped \
    pihole/pihole:latest
