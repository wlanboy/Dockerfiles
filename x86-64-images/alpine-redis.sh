#!/bin/bash

mkdir -p /redisdata 
chown your-user-name:docker /redisdata

cd alpine-redis
docker build -t redisserver:latest . 
docker run -d -p 6379:6379 --name redisserver -v /redisdata:/data redisserver:latest