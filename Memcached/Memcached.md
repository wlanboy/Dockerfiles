# Memcached Docker Setup

Dieses Verzeichnis enthält ein Skript zum Starten eines Memcached Containers via Docker. Memcached ist ein leistungsstarkes, verteiltes In-Memory-Caching-System, das häufig zur Beschleunigung dynamischer Webanwendungen eingesetzt wird, indem Daten und Objekte im RAM zwischengespeichert werden. Es unterstützt sowohl das klassische Textprotokoll als auch das effizientere Binärprotokoll.

## Dateien

| Datei | Beschreibung |
|---|---|
| `run.sh` | Startet den Memcached Container |

## Konfiguration

| Parameter | Wert |
|---|---|
| Image | `memcached:1.6-trixie` |
| Port | `11211` |
| Container-Name | `memcache` |
| Modus | Verbose (`-v`) |

## Verwendung

```bash
chmod +x run.sh
./run.sh
```

## Verbindung testen

```bash
# Über telnet verbinden
telnet localhost 11211

# Beispiel: Wert setzen und lesen
set mykey 0 900 5
hello
get mykey
quit
```

## Hinweise

- Zum Stoppen: `docker stop memcache`
- Zum Entfernen: `docker rm memcache`
- Logs einsehen: `docker logs memcache`
- Memcached speichert Daten ausschließlich im RAM – nach einem Neustart sind alle Daten verloren.
