docker run --name mariadb -p 3306:3306 -v /mariadb/data:/var/lib/mysql -v /mariadb/lowmemory.cnf:/etc/mysql/my.cnf -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=spring -e MYSQL_USER=spring -e MYSQL_PASSWORD=spring -d --restart unless-stopped mariadb:10.5
