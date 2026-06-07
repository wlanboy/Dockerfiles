# Startet Pi-hole — DNS-basierter Werbeblocker für das gesamte Heimnetzwerk.
# $MYIP auf die eigene Host-IP anpassen, DNS1 auf den Router/Gateway.
# Web-UI nach dem Start: http://localhost:8080/admin

export MYIP=192.168.0.10
export DNS1=192.168.0.1   # Upstream-DNS (z.B. Router) für lokale Hostnamen
export DNS2=8.8.8.8       # Fallback-DNS (Google)

# Volumes anlegen (idempotent)
docker volume create pihole-etc
docker volume create pihole-dns

docker run -d --name pihole \
    -p 8080:80 \               # Web-UI
    -p $MYIP:53:53/tcp \       # DNS (TCP, für große Antworten >512 Byte)
    -p $MYIP:53:53/udp \       # DNS (UDP, Standard)
    -p 67:67/udp \             # DHCP (optional, nur wenn Pi-hole als DHCP-Server genutzt wird)
    -v pihole-etc:/etc/pihole/ \       # Pi-hole-Konfiguration, Blocklisten, Datenbank
    -v pihole-dns:/etc/dnsmasq.d/ \    # Eigene DNS-Einträge und dnsmasq-Konfiguration
    -e TZ=Europe/Berlin \
    -e ServerIP=$MYIP \        # Host-IP für DNS-Rebind-Schutz und DHCP
    -e WEBPASSWORD=pihole \    # Web-UI Passwort (siehe password.md zum Ändern)
    -e DNS1=$DNS1 \
    -e DNS2=$DNS2 \
    --restart unless-stopped \
    pihole/pihole:latest
