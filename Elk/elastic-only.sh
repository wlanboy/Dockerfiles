# Startet nur Elasticsearch ohne Kibana und Logstash.
# Neuere Version (7.8.0) als im vollständigen Stack (6.2.3).
# Nützlich zum Testen oder wenn Kibana/Logstash separat verwaltet werden.
docker run --name elastic \
    -p 9200:9200 -p 9300:9300 \
    -m 1024M -d \
    -e "discovery.type=single-node" \
    --restart unless-stopped \
    elastic/elasticsearch:9.4.2
