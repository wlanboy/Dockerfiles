#!/bin/bash

docker run -d --name zookeeper -m 256M -p 2181:2181 -p 2888:2888 -p 3888:3888 zookeeper:3.4
