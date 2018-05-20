# Dockerfiles
Repository for my docker scripts

### Zookeeper
docker run -d --name zookeeper -m 256M -p 2181:2181 -p 2888:2888 -p 3888:3888 zookeeper:3.4

### Kafka
docker run -d --name kafka -p 9092:9092 -p 7203:7203 --link zookeeper:zookeeper --env KAFKA_ADVERTISED_HOST_NAME=127.0.0.1 --env ZOOKEEPER_IP=zookeeper ches/kafka

### Cassandra
docker run --name cassandra -d -e CASSANDRA_BROADCAST_ADDRESS=127.0.0.1 -e CASSANDRA_CLUSTER_NAME=test -p 7000:7000 -p 9042:9042 -m 512M --memory-swap -1 cassandra:3.11

### MySQL
docker run --name mysqldb -p 3306:3306 -m 200M --memory-swap -1 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=test -e MYSQL_USER=test -e MYSQL_PASSWORD=test -d mysql:8

## Data Flow Server Stack
### Build
cd DataFlowServerImage
docker build -t dataflowserver:1.4.0 . --build-arg JAR_FILE=./target/spring-cloud-dataflow-server-local-1.4.0.RELEASE.jar
### Start stack
cd ..
docker-compose -f DataFlowStack.yml up -d
### Stop stack
docker-compose -f DataFlowStack.yml down
### Output of command
Creating network "dataflowserverstack_default" with the default driver
Creating dataflowserverstack_dfszookeeper_1   ... done
Creating dataflowserverstack_dfskafka_1       ... done
Creating dataflowserverstack_dfsmysql_1       ... done
Creating dataflowserverstack_dataflowserver_1 ... done
### Start working
Browser: http://localhost:9393/dashboard/#/apps
### Get into DFS logs
docker exec -it "dataflowserverstack dataflowserver 1" ls /tmp