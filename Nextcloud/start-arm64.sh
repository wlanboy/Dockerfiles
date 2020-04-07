docker run -d -p 8080:80 \
    -v nextcloud:/var/www/html \
    -v apps:/var/www/html/custom_apps \
    -v config:/var/www/html/config \
    -v data:/var/www/html/data \
    arm64v8/nextcloud:18.0.1-fpm-alpine
