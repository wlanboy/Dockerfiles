# Startet einen einzelnen Couchbase-Node.
# Die Web-UI zur Cluster-Konfiguration ist danach erreichbar unter http://localhost:8091
docker run -d --name couchbase \
    -p 8091-8096:8091-8096 \     # 8091: Web-UI/REST, 8092: Views/XDCR, 8093: N1QL, 8094: Search, 8095: Analytics, 8096: Eventing
    -p 11210-11211:11210-11211 \ # 11210: Data Service (Memcached), 11211: Moxi Proxy (Legacy)
    couchbase

# Zweiten Node starten und dem Cluster hinzufügen:
# Kein -p nötig - der zweite Container kommuniziert über das interne Docker-Netzwerk.
# Die IP per "docker inspect" ermitteln und dann in der Web-UI unter
# http://localhost:8091 → "Add Server" eintragen.
docker run -d --name couchbase2 couchbase
echo "IP von couchbase2: $(docker inspect --format '{{ .NetworkSettings.IPAddress }}' couchbase2)"
