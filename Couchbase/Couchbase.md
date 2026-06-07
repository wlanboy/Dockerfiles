# Couchbase Docker Setup (Zwei-Knoten-Cluster)

Dieses Verzeichnis enthält ein Skript zum Starten eines Zwei-Knoten-Couchbase-Clusters via Docker. Couchbase ist eine verteilte NoSQL-Dokumentendatenbank mit integriertem Caching, N1QL-Abfragesprache und Web-UI.

## Dateien

| Datei | Beschreibung |
|---|---|
| `start.sh` | Startet zwei Couchbase-Nodes und gibt die IP des zweiten Nodes aus |

## Konfiguration

| Parameter | Wert |
|---|---|
| Image | `couchbase` (latest) |
| Node 1 | `couchbase` — Port `8091–8096`, `11210–11211` |
| Node 2 | `couchbase2` — kein Port-Mapping (internes Netzwerk) |

### Ports Node 1

| Port | Dienst |
|---|---|
| `8091` | Web-UI und REST API |
| `8092` | Views und XDCR |
| `8093` | N1QL Query Service |
| `8094` | Full-Text Search |
| `8095` | Analytics |
| `8096` | Eventing |
| `11210` | Data Service (Memcached-Protokoll) |
| `11211` | Moxi Proxy (Legacy) |

## Verwendung

```bash
chmod +x start.sh
./start.sh
```

Das Skript gibt nach dem Start die interne IP von `couchbase2` aus.

## Cluster-Einrichtung

1. Web-UI öffnen: `http://localhost:8091`
2. Neuen Cluster anlegen und Admin-Zugangsdaten setzen
3. **Add Server** → IP von `couchbase2` (Ausgabe des Skripts) eintragen
4. Rebalance auslösen

```bash
# IP von couchbase2 manuell abfragen
docker inspect --format '{{ .NetworkSettings.IPAddress }}' couchbase2
```

## Hinweise

- Zum Stoppen: `docker stop couchbase couchbase2`
- Zum Entfernen: `docker rm couchbase couchbase2`
- Logs einsehen: `docker logs couchbase` / `docker logs couchbase2`
