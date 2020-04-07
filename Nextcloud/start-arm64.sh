docker run -d -p 8080:80 --name next \
    -v nextcloud:/var/www/html \
    -v apps:/var/www/html/custom_apps \
    -v config:/var/www/html/config \
    -v data:/var/www/html/data \
    arm64v8/nextcloud:18.0.3-fpm-alpine 
