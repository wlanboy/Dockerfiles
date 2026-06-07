# Prometheus Monitoring Stack

Dieser Docker-Compose-Stack stellt einen vollständigen Monitoring-Stack bereit: Prometheus sammelt Metriken, Node Exporter liefert Host-Metriken, Alertmanager verschickt Benachrichtigungen und Grafana visualisiert alles in Dashboards.

## Dienste

| Dienst | Image | Port | Beschreibung |
|---|---|---|---|
| `prometheus` | `prom/prometheus` | `9090` | Metriken-Speicher und Auswertungs-Engine |
| `node-exporter` | `prom/node-exporter` | `9100` | Exportiert Host-Metriken (CPU, RAM, Disk, Netzwerk) |
| `alertmanager` | `prom/alertmanager` | `9093` | Verarbeitet Alerts und versendet Benachrichtigungen |
| `grafana` | `grafana/grafana` | `3000` | Dashboard-Visualisierung der Prometheus-Metriken |

## Volumes

| Volume | Dienst | Beschreibung |
|---|---|---|
| `prometheus_data` | Prometheus | Persistente Zeitreihendaten (TSDB) |
| `grafana_data` | Grafana | Persistente Dashboard-, Nutzer- und Einstellungsdaten |

## Verzeichnisstruktur

```
PromethusStack/
├── PromethusStack.yml
├── prometheus/
│   └── prometheus.yml          # Scrape-Konfiguration und Alerting-Rules
├── alertmanager/
│   └── config.yml              # Empfänger und Routing-Regeln für Alerts
└── grafana/
    ├── config.monitoring        # Umgebungsvariablen (Admin-Passwort, Plugins)
    └── provisioning/            # Automatische Datasource- und Dashboard-Konfiguration
```

## Verwendung

```bash
# Stack starten
docker compose -f PromethusStack.yml up -d

# Stack stoppen
docker compose -f PromethusStack.yml down

# Logs einsehen
docker compose -f PromethusStack.yml logs -f
```

## Web-Oberflächen

| Dienst | URL |
|---|---|
| Prometheus | http://localhost:9090 |
| Alertmanager | http://localhost:9093 |
| Grafana | http://localhost:3000 |

## Hinweise

- Node Exporter bindet `/proc`, `/sys` und `/` des Hosts read-only ein – der Container benötigt daher Zugriff auf diese Pfade.
- Grafana startet erst, nachdem Prometheus verfügbar ist (`depends_on`).
- Die Konfigurationsdateien unter `prometheus/`, `alertmanager/` und `grafana/provisioning/` müssen vor dem ersten Start vorhanden sein.
- Volumes werden von Docker automatisch angelegt und bleiben beim `docker compose down` erhalten. Zum vollständigen Löschen: `docker compose down -v`.
