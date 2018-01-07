#!/bin/bash

mkdir -p /kafkadata && mkdir -p /kafkalogs 
chown your-user-name:docker /kafkadata /kafkalogs
docker run -d --name kafka -v /kafkadata:/data -v /kafkalogs:/logs -p 9092:9092 -p 7203:7203 --link zookeeper:zookeeper --env KAFKA_ADVERTISED_HOST_NAME=127.0.0.1 --env ZOOKEEPER_IP=zookeeper ches/kafka
