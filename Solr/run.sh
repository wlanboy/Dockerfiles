docker run --name solr-server --restart unless-stopped -d -p 8983:8983 -t -v /mydata:/opt/solr/mydata solr:8.4.1
