# MariaDB Docker Setup

Dieses Verzeichnis enthält Skripte zum Starten eines MariaDB Containers via Docker. MariaDB ist ein leistungsstarkes, quelloffenes relationales Datenbanksystem und ein vollständig kompatibler Fork von MySQL. Es eignet sich für den Einsatz in Entwicklungsumgebungen, auf Einplatinenrechnern und in Produktionssystemen.

## Dateien

| Datei | Beschreibung |
|---|---|
| `start.sh` | Startet MariaDB auf amd64/x86_64-Systemen |
| `start-arm64.sh` | Startet MariaDB auf ARM64-Systemen (Raspberry Pi, Apple M1) |
| `start-local.sh` | Startet MariaDB gebunden an localhost (kein externer Zugriff) |
| `start-low-memory-mariadb.sh` | Startet MariaDB mit minimiertem Speicherverbrauch |
| `mariadb.sh` | Startet MariaDB in einem benutzerdefinierten Docker-Netzwerk mit Init-Skripten |
| `lowmemory.cnf` | MariaDB-Konfiguration für Systeme mit wenig RAM |

## Konfiguration

| Parameter | Wert |
|---|---|
| Image | `mariadb:12-ubi10` |
| Port | `3306` |
| Container-Name | `mariadb` |
| Datenbank | `spring` |
| Benutzer | `spring` |
| Volume | `mariadb_data` (benanntes Docker Volume) |
| Neustart-Richtlinie | `unless-stopped` |

## Verwendung

```bash
chmod +x start.sh
./start.sh
```

## Varianten

### Nur lokal erreichbar
```bash
./start-local.sh
```
Bindet den Port ausschließlich an `127.0.0.1` – kein Zugriff von anderen Netzwerkhosts.

### ARM64 (Raspberry Pi, Apple M1)
```bash
./start-arm64.sh
```

### Niedrige Speichernutzung
```bash
./start-low-memory-mariadb.sh
```
Lädt `lowmemory.cnf` als MariaDB-Konfiguration. Sinnvoll für VMs oder Systeme mit unter 512 MB RAM.

## Verbindung testen

```bash
# MySQL-Client im laufenden Container ausführen
docker exec -it mariadb mariadb -u spring -pspring spring

# Oder von außen via mysql-Client
mysql -h 127.0.0.1 -P 3306 -u spring -pspring spring
```

## Hinweise

- Zum Stoppen: `docker stop mariadb`
- Zum Entfernen: `docker rm mariadb`
- Logs einsehen: `docker logs mariadb`
- Das Image `mariadb:12-ubi10` basiert auf Red Hat Universal Base Image 10 (UBI10).
- Das Volume `mariadb_data` wird per `docker volume create` angelegt und überlebt Container-Neustarts und -Entfernungen.

```bash
# Volume manuell einsehen
docker volume inspect mariadb_data

# Volume löschen (Achtung: alle Daten gehen verloren)
docker volume rm mariadb_data
```
