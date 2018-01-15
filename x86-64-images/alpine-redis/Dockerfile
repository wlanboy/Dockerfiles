FROM alpine:3.4
MAINTAINER wlanboy

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -S redis && adduser -S -G redis redis

# grab su-exec for easy step-down from root
RUN apk add --no-cache 'su-exec>=0.2'

# Install redis
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.4/main" >> /etc/apk/repositories && \
    apk add --update redis=3.2.11-r0 && \
    rm -rf /var/cache/apk/* && \
    mkdir /data && mkdir /etc/redis && \
    chown -R redis:redis /data 

# Add config file
ADD ./redis.conf /etc/redis.conf

VOLUME ["/data"]

# Expose the ports for redis
EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]
