# Pi-hole

DNS-basierter Werbeblocker der Werbung und Tracker für alle Geräte im Heimnetzwerk blockiert —
ohne Browser-Extensions, direkt auf DNS-Ebene. Web-UI erreichbar unter http://localhost:8080/admin

## Wie es funktioniert

Pi-hole fungiert als lokaler DNS-Server. Alle DNS-Anfragen im Netzwerk gehen zuerst durch Pi-hole.
Anfragen für bekannte Werbe- und Tracking-Domains werden geblockt (NXDOMAIN), alle anderen an den Upstream-DNS weitergeleitet.

## Starten

IP-Adressen in `start.sh` anpassen, dann:

```bash
./start.sh
```

## Volumes

| Volume | Pfad im Container | Inhalt |
|--------|------------------|--------|
| `pihole-etc` | `/etc/pihole/` | Konfiguration, Blocklisten-Datenbank, Whitelist/Blacklist |
| `pihole-dns` | `/etc/dnsmasq.d/` | Eigene DNS-Einträge, dnsmasq-Konfiguration |

## Ports

| Port | Protokoll | Zweck |
|------|-----------|-------|
| 8080 | TCP | Web-UI |
| 53 | UDP | DNS (Standard) |
| 53 | TCP | DNS (für Antworten >512 Byte) |
| 67 | UDP | DHCP (optional) |

## Passwort ändern

```bash
docker exec -it pihole /bin/bash
pihole -a -p
```

## Blocklisten

Die Blocklisten aus `hostlists.txt` in der Web-UI unter **Group Management → Adlists** eintragen.
Danach Gravity-Datenbank aktualisieren:

```bash
docker exec pihole pihole -g
```

Enthaltene Listen:

| Liste | Zweck |
|-------|-------|
| StevenBlack/hosts | Kombinierte Werbung & Malware |
| KADhosts | Polnische Werbedomains |
| AdAway | Mobile Werbung (Android) |
| AdGuard DNS | Werbung & Tracker |
| Easylist | Browser-Werbeblocker-Liste |
| pgl.yoyo.org | Werbenetzwerke |
| OSINT Digital Side | Malware-Domains |
| Phishing Army | Phishing-Domains |
| NoTrack Malware | Malware-Domains |
| URLhaus | Aktive Malware-URLs |
| YouTube Ads | YouTube-Werbedomains |

## Pi-hole als DHCP-Server (optional)

Pi-hole kann den Router als DHCP-Server ersetzen — dann bekommen alle Geräte automatisch Pi-hole als DNS.
In der Web-UI unter **Settings → DHCP** aktivieren, vorher DHCP im Router deaktivieren.
