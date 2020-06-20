
docker run --name elastic -p 9200:9200 -p 9300:9300 -m 1024M -d -e "discovery.type=single-node" --restart unless-stopped docker.elastic.co/elasticsearch/elasticsearch:7.8.1
