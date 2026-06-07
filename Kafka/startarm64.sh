# Startet Kafka mit Zookeeper für ARM64-Architektur (z.B. Raspberry Pi, Apple Silicon).
# Schlanker als start.sh: kein eigenes Netzwerk, geringere Memory-Limits (je 256M).
# $DOCKERHOST muss auf die Host-IP zeigen.
# Beispiel: export DOCKERHOST=$(hostname -I | awk '{print $1}')

# Zookeeper - ARM64-Image von arm64v8
docker run -d --name zookeeper \
    -m 256M \
    -p 2181:2181 \
    arm64v8/zookeeper:3.4

# Kafka Broker - ARM64-Image
# 7203: JMX-Port für Monitoring (z.B. mit JConsole oder Prometheus JMX Exporter)
# ZOOKEEPER_IP: Adresse des Zookeepers (hier über Host-IP statt Container-Name)
docker run -d --name kafka \
    -m 256M \
    -p 9092:9092 \
    -p 7203:7203 \
    --env KAFKA_ADVERTISED_HOST_NAME=$DOCKERHOST \
    --env ZOOKEEPER_IP=$DOCKERHOST \
    arm64v8/kafka:latest
