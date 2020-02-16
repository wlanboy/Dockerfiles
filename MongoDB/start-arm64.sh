docker run --name mongodb -p 27017:27017 -v /mongodb:/data/db -e MONGO_INITDB_ROOT_USERNAME=spring -e MONGO_INITDB_ROOT_PASSWORD=spring -d --restart unless-stopped arm64v8/mongo:4.2.3-bionic
