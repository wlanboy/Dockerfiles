# Startet einen Kafka-Broker mit Zookeeper (Confluent Platform, x86_64).
# $DOCKERHOST muss auf die Host-IP zeigen (nicht localhost), damit Clients
# von außerhalb des Docker-Netzwerks den Broker erreichen können.
# Beispiel: export DOCKERHOST=$(hostname -I | awk '{print $1}')

# Isoliertes Netzwerk für die Kommunikation zwischen Zookeeper und Kafka
docker network create kafka

# Zookeeper - verwaltet Cluster-Metadaten und Leader-Election für Kafka
# ZOOKEEPER_TICK_TIME: Heartbeat-Intervall in ms (Basis für Session-Timeouts)
docker run -d --net=kafka --name=zookeeper \
    -m 512M \
    -p 2181:2181 \
    -e ZOOKEEPER_CLIENT_PORT=2181 \
    -e ZOOKEEPER_TICK_TIME=2000 \
    confluentinc/cp-zookeeper:4.1.3

# Warten bis Zookeeper bereit ist, bevor Kafka startet
sleep 10

# Kafka Broker
# KAFKA_ZOOKEEPER_CONNECT: Adresse des Zookeepers (über Host-IP, nicht Container-Name,
#   da Clients außerhalb des Netzwerks denselben Wert für die Verbindung nutzen)
# KAFKA_ADVERTISED_LISTENERS: Adresse die Kafka an Clients zurückmeldet
# KAFKA_BROKER_ID: Eindeutige ID im Cluster (relevant bei mehreren Brokern)
# KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1: Für Single-Broker nötig (Standard wäre 3)
docker run -d --net=kafka --name=kafka \
    -m 1024M \
    -p 9092:9092 \
    -e KAFKA_ZOOKEEPER_CONNECT=$DOCKERHOST:2181 \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$DOCKERHOST:9092 \
    -e KAFKA_BROKER_ID=1 \
    -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
    confluentinc/cp-kafka:4.1.3
