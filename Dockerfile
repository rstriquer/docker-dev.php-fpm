# To build just run: docker build -t rstriquer/php-fpm.dev:7.3 .
FROM php:8.1-fpm
LABEL org.opencontainers.image.authors="https://github.com/rstriquer"

RUN echo "UTC" > /etc/timezone

#install laravel requirements and aditional extensions
RUN requirements="libmcrypt-dev g++ libicu-dev libmcrypt4 libzip-dev zlib1g-dev git libcurl4-openssl-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev" \
    && apt-get update && apt-get install -y $requirements \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install intl \
    && docker-php-ext-install json \
    && docker-php-ext-install zip \
    && docker-php-ext-install curl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install opcache

#install Imagemagick & PHP Imagick ext
RUN apt-get update && apt-get install -y \
    libmagickwand-dev --no-install-recommends

RUN yes | pecl install xdebug
RUN pecl install imagick && docker-php-ext-enable imagick

#install composer globally
RUN curl -sSL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

#replace default php-fpm config
RUN rm -v /usr/local/etc/php-fpm.conf

COPY config/php-fpm.conf /usr/local/etc/

#add custom php.ini
COPY config/php.ini /usr/local/etc/php/
COPY config/xdebug.ini /usr/local/etc/php/conf.d

# Setup Volume
VOLUME ["/var/www/"]

#Set Workdir
WORKDIR /var/www/

#Add entrypoint
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]

