docker run -d --name couchbase -p 8091-8096:8091-8096 -p 11210-11211:11210-11211 couchbase

#docker run -d --name couchbase2 couchbase #second node
#docker inspect --format '{{ .NetworkSettings.IPAddress }}' couchbase2
