# Valkey Docker Setup

Dieses Verzeichnis enthält ein Skript zum Starten eines Valkey Containers via Docker. Valkey ist ein quelloffener Fork von Redis, der unter der BSD-3-Clause-Lizenz weiterentwickelt wird und vollständig kompatibel mit Redis-Clients ist.

## Dateien

| Datei | Beschreibung |
|---|---|
| `run.sh` | Startet den Valkey Container auf amd64/x86_64-Systemen |

## Konfiguration

| Parameter | Wert |
|---|---|
| Image | `valkey/valkey:8-alpine` |
| Port | `6379` |
| RAM-Limit | `512 MB` |
| Docker Volume | `valkey_data` |
| Neustart-Richtlinie | `unless-stopped` |

## Verwendung

```bash
chmod +x run.sh
./run.sh
```

## Persistenz

Daten werden im benannten Docker Volume `valkey_data` gespeichert. Das Volume wird automatisch per `docker volume create` angelegt.

```bash
# Volume manuell einsehen
docker volume inspect valkey_data

# Volume löschen (Achtung: alle Daten gehen verloren)
docker volume rm valkey_data
```

## Kompatibilität

Valkey spricht das RESP-Protokoll und ist vollständig kompatibel mit bestehenden Redis-Clients und -Libraries. Ein Wechsel von Redis erfordert lediglich das Austauschen des Images – keine Änderungen am Anwendungscode.

## Hinweise

- Zum Stoppen: `docker stop valkey`
- Zum Entfernen: `docker rm valkey`
- Logs einsehen: `docker logs valkey`
- CLI verbinden: `docker exec -it valkey valkey-cli`
