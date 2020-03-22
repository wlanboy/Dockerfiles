docker run -d --restart=always --name wekan-db mongo:4.0
docker run -d --restart=always --name wekan --link "wekan-db:db" -e "WITH_API=true" -e "MONGO_URL=mongodb://db" -e "ROOT_URL=http://nuc:2000" -p 2000:8080 quay.io/wekan/wekan:v3.84
