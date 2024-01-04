docker run --name postgres -d -p 5432:5432 -v /postgresdata:/var/lib/postgresql/data -v $PWD/postgres.sql:/docker-entrypoint-initdb.d/init.sql -e POSTGRES_PASSWORD=spring -e POSTGRES_USER=spring -e POSTGRES_DB=spring --restart unless-stopped arm64v8/postgres:16.1-alpine
