# PostgreSQL Docker Setup

Dieses Verzeichnis enthält Skripte zum Starten eines PostgreSQL 16.1 Containers via Docker – wahlweise für amd64- oder ARM64-Systeme. Die Datenbank wird mit einem Init-Skript vorkonfiguriert und persistiert ihre Daten auf dem Host.

## Dateien

| Datei | Beschreibung |
|---|---|
| `start.sh` | Startet den Container auf amd64/x86_64-Systemen |
| `start-arm64.sh` | Startet den Container auf ARM64-Systemen (Raspberry Pi, Apple M1/M2) |
| `postgres.sql` | Init-SQL-Skript: wird beim ersten Start automatisch ausgeführt |

## Konfiguration

| Parameter | Wert |
|---|---|
| Image (amd64) | `postgres:16.1-alpine` |
| Image (ARM64) | `arm64v8/postgres:16.1-alpine` |
| Port | `5432` |
| Datenbank | `spring` |
| Benutzer | `spring` |
| Passwort | `spring` |
| Docker Volume | `postgresdata` |
| Neustart-Richtlinie | `unless-stopped` |

## Verwendung

### amd64 / x86_64

```bash
chmod +x start.sh
./start.sh
```

### ARM64

```bash
chmod +x start-arm64.sh
./start-arm64.sh
```

## Init-Skript

`postgres.sql` wird vom Container beim allerersten Start (leeres Datenvolumen) automatisch ausgeführt. Aktuell legt es einen zusätzlichen Testbenutzer und eine Testdatenbank an:

```sql
CREATE USER test PASSWORD 'test';
CREATE DATABASE test;
GRANT ALL PRIVILEGES ON DATABASE test TO test;
```

## Persistenz

Die Datenbankdateien werden in einem benannten Docker Volume (`postgresdata`) gespeichert. Das Volume wird von den Skripten automatisch per `docker volume create` angelegt, falls es noch nicht existiert. Beim Löschen des Containers bleiben die Daten erhalten.

```bash
# Volume manuell einsehen
docker volume inspect postgresdata

# Volume löschen (Achtung: alle Daten gehen verloren)
docker volume rm postgresdata
```

## Hinweise

- Das Init-Skript wird nur beim ersten Start eines leeren Datenvolumens ausgeführt.
- Zum Stoppen des Containers: `docker stop postgres`
- Zum Entfernen des Containers: `docker rm postgres`
- Logs einsehen: `docker logs postgres`
