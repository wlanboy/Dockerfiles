# Named Volumes für persistente Datenspeicherung anlegen.
# "docker volume create" ist idempotent - bereits vorhandene Volumes werden übersprungen.
docker volume create consul-data-master
docker volume create consul-data-server

# Master-Server (Bootstrap-Node)
# -bootstrap-expect 2: Cluster startet erst, wenn 2 Server verbunden sind (Quorum)
# -advertise: IP-Adresse, über die andere Nodes diesen Server erreichen
docker run -d -h consul-node1 \
    -v consul-data-master:/data \
    -p 192.168.178.60:8300:8300 \       # RPC - interne Cluster-Kommunikation
    -p 192.168.178.60:8301:8301 \       # Serf LAN - Gossip-Protokoll (TCP)
    -p 192.168.178.60:8301:8301/udp \   # Serf LAN - Gossip-Protokoll (UDP)
    -p 192.168.178.60:8302:8302 \       # Serf WAN - Gossip über Datacenter (TCP)
    -p 192.168.178.60:8302:8302/udp \   # Serf WAN - Gossip über Datacenter (UDP)
    -p 192.168.178.60:8400:8400 \       # CLI RPC (veraltet ab Consul 1.3, aber noch unterstützt)
    -p 192.168.178.60:8500:8500 \       # HTTP API + Web UI
    -p 192.168.178.60:8600:8600/udp \   # DNS-Interface für Service Discovery
    consul:1.6.3 agent -server -advertise 192.168.178.60 -bootstrap-expect 2

# Zweiter Server-Node
# -join: Adresse des Bootstrap-Nodes, über den der Cluster gefunden wird
docker run -d -h consul-node2 \
    -v consul-data-server:/data \
    -p 192.168.178.61:8300:8300 \
    -p 192.168.178.61:8301:8301 \
    -p 192.168.178.61:8301:8301/udp \
    -p 192.168.178.61:8302:8302 \
    -p 192.168.178.61:8302:8302/udp \
    -p 192.168.178.61:8400:8400 \
    -p 192.168.178.61:8500:8500 \
    -p 192.168.178.61:8600:8600/udp \
    consul:1.6.3 agent -server -advertise 192.168.178.61 -join 192.168.178.60
