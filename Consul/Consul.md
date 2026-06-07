# Consul Docker Setup (Zwei-Server-Cluster)

Dieses Verzeichnis enthält ein Skript zum Starten eines Consul-Clusters mit zwei Server-Nodes via Docker. Consul ist ein Service-Mesh- und Service-Discovery-Tool von HashiCorp. Es bietet Health-Checking, Key-Value-Store, DNS-basierte Service Discovery und eine Web-UI.

## Dateien

| Datei | Beschreibung |
|---|---|
| `start.sh` | Legt Named Volumes an und startet zwei Consul Server-Nodes |

## Konfiguration

| Parameter | Node 1 | Node 2 |
|---|---|---|
| Image | `consul:1.6.3` | `consul:1.6.3` |
| Container-Name | `consul-node1` | `consul-node2` |
| Bind-IP | `192.168.178.60` | `192.168.178.61` |
| Volume | `consul-data-master` | `consul-data-server` |

### Ports (je Node)

| Port | Protokoll | Dienst |
|---|---|---|
| `8300` | TCP | RPC – interne Cluster-Kommunikation |
| `8301` | TCP+UDP | Serf LAN – Gossip-Protokoll |
| `8302` | TCP+UDP | Serf WAN – Gossip über Datacenter |
| `8400` | TCP | CLI RPC (veraltet ab 1.3) |
| `8500` | TCP | HTTP API und Web-UI |
| `8600` | UDP | DNS-Interface für Service Discovery |

## Verwendung

```bash
chmod +x start.sh
./start.sh
```

Die Consul Web-UI ist danach unter `http://192.168.178.60:8500` erreichbar.

## Cluster-Verhalten

- `-bootstrap-expect 2`: Der Cluster wartet auf 2 verbundene Server, bevor er einen Leader wählt (Quorum)
- Node 2 verbindet sich über `-join 192.168.178.60` automatisch mit Node 1
- Beide Nodes benötigen feste IPs auf dem Host (`192.168.178.60` / `.61`)

## Service Discovery (DNS)

Consul beantwortet DNS-Anfragen auf Port `8600`. Services können per Hostname aufgelöst werden:

```bash
# Service per DNS abfragen
dig @192.168.178.60 -p 8600 myservice.service.consul

# Gesunde Nodes eines Services
dig @192.168.178.60 -p 8600 myservice.service.consul SRV
```

## Hinweise

- Zum Stoppen: `docker stop consul-node1 consul-node2`
- Zum Entfernen: `docker rm consul-node1 consul-node2`
- Logs einsehen: `docker logs consul-node1`
- Volumes: `consul-data-master`, `consul-data-server` (überleben Container-Neustarts)

```bash
docker volume rm consul-data-master consul-data-server
```
