docker run --name mysqldb -p 3306:3306 -v /mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=spring -e MYSQL_USER=spring -e MYSQL_PASSWORD=spring -d --restart unless-stopped arm64v8/mariadb:10.3.22