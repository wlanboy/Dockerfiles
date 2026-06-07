# Erstellt ein Hadoop-Cluster mit YARN, NameNode und DataNode.
# Alle Container laufen im selben Docker-Netzwerk "hadoop" und erreichen sich per Hostname.

# Isoliertes Netzwerk für die Cluster-Kommunikation
docker network create hadoop

# YARN ResourceManager - verwaltet Ressourcen und plant Jobs im Cluster
# 8032: ResourceManager RPC (von Clients und ApplicationMaster genutzt)
# 8088: Web-UI für Job-Übersicht → http://localhost:8088
docker run -d --net hadoop --net-alias yarnmaster --name yarnmaster -h yarnmaster \
    -p 8032:8032 \
    -p 8088:8088 \
    --restart unless-stopped \
    swapnillinux/cloudera-hadoop-yarnmaster

# HDFS NameNode - verwaltet das Dateisystem-Verzeichnis (Metadaten, keine Nutzdaten)
# 8020: HDFS RPC für Clients und DataNodes
# 50070: Web-UI für HDFS-Übersicht → http://localhost:50070
# 50090: Secondary NameNode HTTP
docker run -d --net hadoop --net-alias namenode --name namenode -h namenode \
    -p 8020:8020 \
    -p 50070:50070 \
    -p 50090:50090 \
    --restart unless-stopped \
    swapnillinux/cloudera-hadoop-namenode

# HDFS DataNode - speichert die eigentlichen Datenblöcke
# Kein Host-Port nötig, kommuniziert intern über das hadoop-Netzwerk
docker run -d --net hadoop --net-alias datanode1 --name datanode1 -h datanode1 \
    --link namenode --link yarnmaster \
    swapnillinux/cloudera-hadoop-datanode

# HDFS initialisieren: Berechtigungen setzen und Verzeichnisse anlegen
docker exec namenode hdfs dfs -chmod -R 777 /
docker exec namenode hdfs dfs -mkdir /user1
docker exec namenode hdfs dfs -mkdir /user2

# Testdatei (10 MB) erzeugen und in HDFS hochladen
docker exec namenode dd if=/dev/zero of=/tmp/file.txt bs=1M count=10
docker exec namenode hdfs dfs -put /tmp/file.txt /user1/file.txt
