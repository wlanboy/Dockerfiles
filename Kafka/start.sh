docker run -d --net=kafka --name=zookeeper -m 512M -p 2181:2181 -e ZOOKEEPER_CLIENT_PORT=2181 -e ZOOKEEPER_TICK_TIME=2000 confluentinc/cp-zookeeper:4.1.3
sleep 10
docker run -d --net=kafka --name=kafka -m 1024M -p 9092:9092 -e KAFKA_ZOOKEEPER_CONNECT=$DOCKERHOST:2181 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$DOCKERHOST:9092 -e KAFKA_BROKER_ID=1 -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 confluentinc/cp-kafka:4.1.3
