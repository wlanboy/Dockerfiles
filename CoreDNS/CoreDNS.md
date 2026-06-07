# CoreDNS Docker Setup

Dieses Verzeichnis enthält Skripte und Konfigurationsdateien für einen CoreDNS-Server via Docker. CoreDNS ist ein leichtgewichtiger, erweiterbarer DNS-Server, der sich besonders für den Einsatz in Heimnetzwerken und als interner Service-Discovery-DNS eignet. Die Konfiguration enthält eine lokale Zone für interne Hostnamen sowie Forwarding für alle anderen Anfragen.

## Dateien

| Datei | Beschreibung |
|---|---|
| `run.sh` | Startet CoreDNS mit relativem Konfigurationspfad (`$PWD`) |
| `runhost.sh` | Startet CoreDNS mit absolutem Pfad (für systemd-Services oder Cron-Jobs) |
| `coredns/Corefile` | CoreDNS-Hauptkonfiguration mit Zonen-Definitionen |
| `coredns/wlanboyservice.db` | DNS-Zonendatei für `wlanboyservice.com` |

## Konfiguration

| Parameter | Wert |
|---|---|
| Image | `coredns/coredns` (latest) |
| Container-Name | `coredns` |
| DNS-Port | `53/udp` |
| Neustart-Richtlinie | `always` |

## DNS-Zonen

| Zone | Typ | Beschreibung |
|---|---|---|
| `.` | Forward | Alle unbekannten Anfragen → `8.8.8.8`, `9.9.9.9` |
| `wlanboyservice.com` | Lokal | Interne Hostnamen aus `wlanboyservice.db` |

### Einträge in `wlanboyservice.db`

| Hostname | IP |
|---|---|
| `dns.wlanboyservice.com` | `192.168.178.112` |
| `cloudconfig.wlanboyservice.com` | `192.168.178.112` |

## Verwendung

```bash
# Aus dem Repo-Verzeichnis heraus
chmod +x run.sh
./run.sh

# Als systemd-Service oder Cron-Job (absoluter Pfad)
chmod +x runhost.sh
./runhost.sh
```

## Lokalen DNS-Eintrag hinzufügen

Neue Zeile in `coredns/wlanboyservice.db` eintragen:

```
myservice.wlanboyservice.com.    IN  A   192.168.178.100
```

CoreDNS lädt die Zonendatei automatisch neu (`reload`-Plugin aktiv) – kein Container-Neustart nötig.

## Hinweise

- Zum Stoppen: `docker stop coredns`
- Zum Entfernen: `docker rm coredns`
- Logs einsehen: `docker logs coredns`
- Port 53 erfordert ggf. Root-Rechte oder `CAP_NET_BIND_SERVICE`
