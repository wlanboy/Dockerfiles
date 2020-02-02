docker network create hadoop
docker run -d --net hadoop --net-alias yarnmaster --name yarnmaster -h yarnmaster -p 8032:8032 -p 8088:8088 --restart unless-stopped swapnillinux/cloudera-hadoop-yarnmaster
docker run -d --net hadoop --net-alias namenode --name namenode -h namenode -p 8020:8020 -p 50070:50070 -p 50090:50090 --restart unless-stopped swapnillinux/cloudera-hadoop-namenode
docker run -d --net hadoop --net-alias datanode1 --name datanode1 -h datanode1 --link namenode --link yarnmaster swapnillinux/cloudera-hadoop-datanode
docker exec namenode hdfs dfs -chmod -R 777 /
