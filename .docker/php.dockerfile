FROM php:8.1.12-fpm

COPY ./.docker/php.ini /usr/local/etc/php/conf.d/php.ini

# Download and install Composer
RUN set -x \
    && php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
    && php /tmp/composer-setup.php --version=2.1.3 --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /tmp/composer-setup.php

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    libzip-dev \
    zip \
    unzip \
    libwebp-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    vim \
    nano \
    && apt-get install -y yarn \
    && apt-get -y autoremove

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql fileinfo zip pcntl gd

WORKDIR /var/www
