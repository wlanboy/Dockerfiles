FROM php:7.4-fpm-buster

# ENV Stuff
ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" 
    
# Libs und Headers Stuff
RUN set -x \
    && apt-get update && apt-get install -y \
        imagemagick \
        graphicsmagick \
        ghostscript \
        jpegoptim \
        libjpeg-turbo-progs \
        pngcrush \
        optipng \
        apngopt \
        pngnq \
        pngquant \
        # Libs
        libxslt1.1 \
        zlibc \
        zlib1g \
        libpq5 \
        libpng16-16 \
        libmcrypt4 \
        libzip4 \
        # Headers
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        libbz2-dev \
        libicu-dev \
        libldb-dev \
        libmcrypt-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        libmemcached-dev \
        libpng-dev \
        libpq-dev \
        libzip-dev \
        libc-client-dev \
        libc-client2007e-dev \
        libkrb5-dev \
        libmagick++-dev
        
# PHP Extensions
RUN set -x \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install \
        bcmath \
        bz2 \
        calendar \
        exif \
        intl \
        gettext \
        mysqli \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        tokenizer \
        sysvmsg \
        sysvsem \
        sysvshm \
        shmop \
        xsl \
        zip \
        gd \
        gettext \
        opcache \
    && pecl install mongodb \
    && pecl install imagick \
    && echo extension=imagick.so > /usr/local/etc/php/conf.d/imagick.ini \
    && echo extension=mongodb.so > /usr/local/etc/php/conf.d/mongodb.ini 
    
WORKDIR / 
EXPOSE 9000 
CMD ["php-fpm"]

#docker stop php7fpm && docker rm php7fpm 
#docker build -t php7fpm:7.3 .
#docker run -d --name php7fpm -v /php7:/var/www/html -p 9000:9000 php7fpm:7.3
