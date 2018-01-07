#!/bin/bash

mkdir -p /cassandradata 
chown your-user-name:docker /cassandradata 

docker run --name cassandra -d -v /cassandradata:/var/lib/cassandra -d -e CASSANDRA_BROADCAST_ADDRESS=EXTERNAL-DOCKER-IP -e CASSANDRA_CLUSTER_NAME=ruby -p 7000:7000 -p 9042:9042 -m 512M --memory-swap -1 cassandra:3.11

#start cqlsh console
#docker run -it --link cassandra:cassandra --rm cassandra cqlsh cassandra
#CREATE KEYSPACE your_keyspace WITH replication = { 'class': 'SimpleStrategy', 'replication_factor': 1 };