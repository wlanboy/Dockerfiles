docker run -d --name zookeeper -m 256M -p 2181:2181 arm64v8/zookeeper:3.4
docker run -d --name kafka -m 256M -p 9092:9092 -p 7203:7203 --env KAFKA_ADVERTISED_HOST_NAME=$DOCKERHOST --env ZOOKEEPER_IP=$DOCKERHOST arm64v8/kafka:latest
