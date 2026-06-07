# Kafka Docker Setup

Dieses Verzeichnis enthält Skripte zum Starten eines Apache Kafka Brokers mit Zookeeper via Docker. Kafka ist eine verteilte Event-Streaming-Plattform für hochdurchsatzfähige, fehlertolerante Nachrichtenverarbeitung. Die enthaltene Konfiguration ist als Single-Broker-Setup für Entwicklung und lokale Umgebungen ausgelegt.

## Dateien

| Datei | Beschreibung |
|---|---|
| `start.sh` | Startet Zookeeper und Kafka auf amd64/x86_64 (Confluent Platform) |
| `startarm64.sh` | Startet Zookeeper und Kafka auf ARM64 (Raspberry Pi, Apple Silicon) |

## Konfiguration

### amd64 (`start.sh`)

| Dienst | Image | Port | RAM-Limit |
|---|---|---|---|
| Zookeeper | `confluentinc/cp-zookeeper:4.1.3` | `2181` | 512 MB |
| Kafka | `confluentinc/cp-kafka:4.1.3` | `9092` | 1024 MB |

### ARM64 (`startarm64.sh`)

| Dienst | Image | Port | RAM-Limit |
|---|---|---|---|
| Zookeeper | `arm64v8/zookeeper:3.4` | `2181` | 256 MB |
| Kafka | `arm64v8/kafka:latest` | `9092`, `7203` (JMX) | 256 MB |

## Voraussetzung: DOCKERHOST setzen

Kafka meldet seinen Broker-Endpunkt an Clients zurück. Dafür muss `$DOCKERHOST` auf die tatsächliche Host-IP zeigen — **nicht** `localhost`, da Clients außerhalb des Docker-Netzwerks sonst nicht verbinden können:

```bash
export DOCKERHOST=$(hostname -I | awk '{print $1}')
```

## Verwendung

```bash
export DOCKERHOST=$(hostname -I | awk '{print $1}')
chmod +x start.sh
./start.sh
```

Das Skript wartet 10 Sekunden auf Zookeeper, bevor Kafka startet.

## Topic erstellen

```bash
docker exec kafka kafka-topics \
  --create \
  --topic mein-topic \
  --partitions 1 \
  --replication-factor 1 \
  --bootstrap-server localhost:9092
```

## Nachrichten senden und empfangen

```bash
# Producer
docker exec -it kafka kafka-console-producer \
  --topic mein-topic \
  --bootstrap-server localhost:9092

# Consumer
docker exec -it kafka kafka-console-consumer \
  --topic mein-topic \
  --from-beginning \
  --bootstrap-server localhost:9092
```

## Spring Boot Konfiguration

```yaml
spring:
  kafka:
    bootstrap-servers: ${DOCKERHOST}:9092
    consumer:
      group-id: my-group
      auto-offset-reset: earliest
```

## Hinweise

- Zum Stoppen: `docker stop kafka zookeeper`
- Zum Entfernen: `docker rm kafka zookeeper`
- Netzwerk entfernen: `docker network rm kafka`
- Logs einsehen: `docker logs kafka` / `docker logs zookeeper`
- `KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1` ist für Single-Broker-Betrieb erforderlich (Standard wäre 3)
- Zookeeper ist ab Kafka 4.0 nicht mehr erforderlich (KRaft-Modus) — für neuere Images ggf. anpassen
