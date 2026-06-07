# ELK Stack Docker Compose Setup

Dieses Verzeichnis enthält eine Docker Compose Konfiguration für den vollständigen ELK-Stack: Elasticsearch, Kibana und Logstash. Der Stack wird im bestehenden Docker-Netzwerk `spring-net` betrieben und dient zur zentralen Log-Aggregation für Spring-Boot-Anwendungen.

## Dateien

| Datei | Beschreibung |
|---|---|
| `ElkStack.yml` | Docker Compose Konfiguration für den gesamten Stack |
| `start-elk.sh` | Startet den Stack via Docker Compose |
| `logstash/logstash.conf` | Logstash-Pipeline: TCP-Eingang → Grok-Filter → Elasticsearch |

## Konfiguration

| Dienst | Image | Port(s) | RAM-Limit |
|---|---|---|---|
| Elasticsearch | `elastic/elasticsearch:9.4.2` | `9200` (HTTP), `9300` (Cluster) | 1024 MB |
| Kibana | `elastic/kibana:8.19.16` | `5601` (Web-UI) | 1024 MB |
| Logstash | `elastic/logstash:8.19.16` | `5044` (TCP-Eingang) | 256 MB |

## Netzwerk

Der Stack läuft im externen Docker-Netzwerk `spring-net`. Das Netzwerk muss vor dem Start existieren:

```bash
docker network create spring-net
```

## Verwendung

```bash
chmod +x start-elk.sh
./start-elk.sh
```

Kibana ist danach unter `http://localhost:5601` erreichbar.

## Logstash-Pipeline

Die Pipeline in `logstash/logstash.conf` empfängt Logs über TCP auf Port `5044` als JSON und verarbeitet sie mit Grok-Filtern speziell für das Spring-Boot-Logformat:

- Erkennt Stack-Traces und versieht sie mit dem Tag `stacktrace`
- Extrahiert `timestamp`, `level`, `pid`, `thread`, `class` und `logmessage`
- Schreibt in Elasticsearch-Indizes nach dem Schema `elk-YYYY.MM.dd`

### Spring Boot Konfiguration (Logback)

```xml
<appender name="LOGSTASH" class="net.logstash.logback.appender.LogstashTcpSocketAppender">
    <destination>localhost:5044</destination>
    <encoder class="net.logstash.logback.encoder.LogstashEncoder"/>
</appender>
```

## Hinweise

- Zum Stoppen: `docker-compose -f ElkStack.yml down`
- Logs einsehen: `docker-compose -f ElkStack.yml logs -f`
- Elasticsearch startet zuerst; Kibana und Logstash warten über `depends_on`
