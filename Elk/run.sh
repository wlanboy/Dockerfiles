# Startet den vollständigen ELK-Stack: Elasticsearch, Kibana und Logstash.
# Reihenfolge wichtig: Elasticsearch muss laufen bevor Kibana und Logstash starten.
# Offizielle Docker Hub Images: https://hub.docker.com/_/elasticsearch

# Elasticsearch - Single-Node-Modus (kein Cluster, für lokale Entwicklung)
# -m 1024M: JVM-Heap auf 1 GB begrenzen
# 9200: HTTP REST API, 9300: internes Cluster-Kommunikationsprotokoll
docker run --name elastic \
    -p 9200:9200 -p 9300:9300 \
    -m 1024M -d \
    -e "discovery.type=single-node" \
    --restart unless-stopped \
    elastic/elasticsearch:9.4.2

# Kibana - Web-UI für Elasticsearch
# --link verbindet Kibana mit dem elastic-Container unter dem Alias "elasticsearch"
# UI erreichbar unter http://localhost:5601
docker run --name kibana \
    -p 5601:5601 \
    -m 1024M -d \
    --link elastic:elasticsearch \
    --restart unless-stopped \
    elastic/kibana:8.19.16

# Logstash - Log-Verarbeitung und Weiterleitung an Elasticsearch
# 5044: TCP-Eingang für Logs (JSON, definiert in logstash.conf)
# 9600: Logstash Monitoring API
# Das Pipeline-Verzeichnis (./logstash/) wird in den Container gemountet
docker run --name logstash \
    -d \
    -p 5044:5044 \
    -p 9600:9600 \
    -v $PWD/logstash:/usr/share/logstash/pipeline \
    --link elastic:elasticsearch \
    --restart unless-stopped \
    elastic/logstash:8.19.16
