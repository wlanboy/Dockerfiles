#!/bin/bash

mkdir -p /mysqldata 
chown your-user-name:docker /mysqldata

docker run --name mysqldb -v /mysqldata:/var/lib/mysql -p 3306:3306 -m 200M --memory-swap -1 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=ruby -e MYSQL_USER=ruby -e MYSQL_PASSWORD=ruby -d mysql:8
