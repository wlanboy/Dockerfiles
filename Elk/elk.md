# ELK Stack Docker Setup (einzelne Container)

Dieses Verzeichnis enthält Skripte zum Starten des ELK-Stacks als einzelne Docker-Container (ohne Compose). Die Logstash-Pipeline ist auf das Spring-Boot-Logformat ausgelegt. Für den Compose-basierten Stack siehe [ElkStack](../ElkStack/).

## Dateien

| Datei | Beschreibung |
|---|---|
| `run.sh` | Startet Elasticsearch, Kibana und Logstash |
| `elastic-only.sh` | Startet nur Elasticsearch (ohne Kibana und Logstash) |
| `logstash/logstash.conf` | Logstash-Pipeline: TCP-Eingang → Grok-Filter → Elasticsearch |

## Konfiguration

| Dienst | Image | Port(s) | RAM-Limit |
|---|---|---|---|
| Elasticsearch | `elastic/elasticsearch:9.4.2` | `9200` (HTTP), `9300` (Cluster) | 1024 MB |
| Kibana | `elastic/kibana:8.19.16` | `5601` (Web-UI) | 1024 MB |
| Logstash | `elastic/logstash:8.19.16` | `5044` (TCP), `9600` (Monitoring API) | – |

## Verwendung

### Vollständiger Stack

```bash
chmod +x run.sh
./run.sh
```

Kibana ist danach unter `http://localhost:5601` erreichbar.

### Nur Elasticsearch

```bash
chmod +x elastic-only.sh
./elastic-only.sh
```

Nützlich zum Testen oder wenn Kibana und Logstash separat verwaltet werden.

## Logstash-Pipeline

Die Pipeline empfängt Logs über TCP auf Port `5044` als JSON. Grok-Filter extrahieren aus Spring-Boot-Logzeilen:

- `timestamp`, `level`, `pid`, `thread`, `class`, `logmessage`
- Stack-Traces werden mit dem Tag `stacktrace` versehen
- Ausgabe in Elasticsearch auf `nuc:9200`, Index `elk-YYYY.MM.dd`

### Spring Boot Konfiguration (Logback)

```xml
<appender name="LOGSTASH" class="net.logstash.logback.appender.LogstashTcpSocketAppender">
    <destination>localhost:5044</destination>
    <encoder class="net.logstash.logback.encoder.LogstashEncoder"/>
</appender>
```

## Hinweise

- Zum Stoppen: `docker stop elastic kibana logstash`
- Zum Entfernen: `docker rm elastic kibana logstash`
- Logs einsehen: `docker logs elastic` / `docker logs kibana` / `docker logs logstash`
- Reihenfolge: Elasticsearch muss gestartet sein, bevor Kibana und Logstash verbinden
