docker run --name elastic -p 9200:9200 -p 9300:9300 -m 1024M -d -e "discovery.type=single-node" --restart unless-stopped docker.elastic.co/elasticsearch/elasticsearch:6.2.3
docker run --name kibana -p 5601:5601 -m 1024M -d --link elastic:elasticsearch --restart unless-stopped docker.elastic.co/kibana/kibana:6.2.3
docker run --name logstash -d -p 5000:5000 -p 9600:9600 -v ~/logstash:/usr/share/logstash/pipeline --link elastic:elasticsearch --restart unless-stopped docker.elastic.co/logstash/logstash:6.2.3
