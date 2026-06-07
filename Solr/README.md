# Solr

Startet Apache Solr als Docker-Container auf Basis des offiziellen `solr:10-slim`-Images. Der Container ist für den Dauerbetrieb konfiguriert und speichert Cores und Indizes in einem persistenten Host-Verzeichnis.

## Voraussetzungen

- Docker installiert und gestartet
- Verzeichnis `/mydata` auf dem Host vorhanden (oder Pfad in `run.sh` anpassen)

## Verwendung

```bash
bash run.sh
```

Nach dem Start ist die Solr Web-UI unter [http://localhost:8983/solr](http://localhost:8983/solr) erreichbar.

## Konfiguration

| Parameter | Wert | Beschreibung |
|-----------|------|--------------|
| Image | `solr:10-slim` | Offizielles Solr 10 Image (schlanke Variante) |
| Port | `8983` | Solr Web-UI und REST-API |
| Datenverzeichnis | `/mydata` → `/opt/solr/mydata` | Persistenter Speicher für Cores und Indizes |
| Restart-Policy | `unless-stopped` | Automatischer Neustart beim Systemstart |

## Nützliche Befehle

```bash
# Container-Status anzeigen
docker ps -f name=solr-server

# Logs anzeigen
docker logs -f solr-server

# Container stoppen
docker stop solr-server

# Container entfernen
docker rm solr-server
```
