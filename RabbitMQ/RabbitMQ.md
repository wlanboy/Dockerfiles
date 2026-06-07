# RabbitMQ Docker Setup

Dieses Verzeichnis enthält Skripte zum Starten eines RabbitMQ 3.8.2 Containers via Docker – wahlweise für amd64- oder ARM64-Systeme. RabbitMQ wird mit aktiviertem Management-Plugin gestartet und stellt AMQP- sowie Management-Ports bereit.

## Dateien

| Datei | Beschreibung |
|---|---|
| `run.sh` | Startet den Container auf amd64/x86_64-Systemen |
| `start-arm64.sh` | Startet den Container auf ARM64-Systemen (Raspberry Pi, Apple M1/M2) |

## Konfiguration

| Parameter | Wert |
|---|---|
| Image (amd64) | `rabbitmq:3.8.2-management` |
| Image (ARM64) | `arm64v8/rabbitmq:3.8.2-management` |
| Management-UI | Port `15672` |
| AMQP (unverschlüsselt) | Port `5672` |
| AMQP (TLS) | Port `5671` |
| Hostname | `nuc` |
| Docker Volume | `rabbitmq_data` |

## Verwendung

### amd64 / x86_64

```bash
chmod +x run.sh
./run.sh
```

### ARM64

```bash
chmod +x start-arm64.sh
./start-arm64.sh
```

## Ports

| Port | Protokoll | Beschreibung |
|---|---|---|
| `15672` | HTTP | Management-Web-UI und REST-API |
| `5672` | AMQP | Nachrichten-Broker (unverschlüsselt) |
| `5671` | AMQPS | Nachrichten-Broker (TLS-verschlüsselt) |

## Management-UI

Die Web-Oberfläche ist nach dem Start unter http://localhost:15672 erreichbar.  
Standardzugangsdaten: **Benutzer** `guest` / **Passwort** `guest`.

## Persistenz

Die Broker-Daten (Queues, Exchanges, Bindings, Nachrichten) werden im benannten Docker Volume `rabbitmq_data` gespeichert. Das Volume wird von den Skripten automatisch per `docker volume create` angelegt.

```bash
# Volume manuell einsehen
docker volume inspect rabbitmq_data

# Volume löschen (Achtung: alle Daten gehen verloren)
docker volume rm rabbitmq_data
```

## Hinweise

- Der `--hostname`-Parameter ist für RabbitMQ wichtig: Die Node-Identität wird aus dem Hostnamen gebildet. Ein fester Hostname verhindert Datenverlust beim Neustart des Containers.
- Zum Stoppen: `docker stop rabbitmq`
- Zum Entfernen: `docker rm rabbitmq`
- Logs einsehen: `docker logs rabbitmq`
