FROM php:8.1.12-fpm

COPY ./.docker/php.ini /usr/local/etc/php/conf.d/php.ini

RUN set -x \
   && php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
   && php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') !== trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'ERROR: Invalid installer signature' . PHP_EOL; unlink('/tmp/composer-setup.php'); exit(1); }" \
   && php /tmp/composer-setup.php --version=2.1.3 --install-dir=/usr/local/bin --filename=composer  \
   && rm -rf /tmp/composer-setup.php

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

RUN docker-php-ext-install pdo_mysql fileinfo zip pcntl gd
# RUN docker-php-ext-configure gd
# RUN docker-php-ext-install gd

WORKDIR /var/www