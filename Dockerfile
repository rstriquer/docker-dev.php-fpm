# To build just run: docker build -t rstriquer/php-fpm.dev:8.2-dev .
FROM php:8.2-fpm
LABEL org.opencontainers.image.authors="https://github.com/rstriquer"

RUN echo "UTC" > /etc/timezone

RUN apt-get update && apt-get install -y apt-utils && apt-get update

RUN apt install -y curl libmemcached-dev libz-dev libpq-dev libjpeg-dev \
    libpng-dev libfreetype6-dev libssl-dev libwebp-dev libxpm-dev \
    libmcrypt-dev libonig-dev build-essential libncurses5-dev zlib1g-dev \
    libnss3-dev libgdbm-dev libsqlite3-dev libffi-dev libreadline-dev \
    libbz2-dev

# @see https://laracasts.com/discuss/channels/laravel/install-imagemagick-on-docker
# RUN apt-get install -y ghostscript;
# RUN apt-get install -y libmagickwand-dev --no-install-recommends

RUN rm -rf /var/lib/apt/lists/*


RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-configure gd \
    --prefix=/usr \
    --with-jpeg \
    --with-webp \
    --with-xpm \
    --with-freetype; \
    docker-php-ext-install gd;

RUN yes | pecl install xdebug

# RUN pecl install imagick-6.9 && docker-php-ext-enable imagick
# RUN sed -i 's/policy domain="coder" rights="none" pattern="PDF"/policy domain="coder" rights="read|write" pattern="PDF"/' /etc/ImageMagick-6/policy.xml

#install composer globally
RUN curl -sSL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

#replace default php-fpm config
RUN rm -v /usr/local/etc/php-fpm.conf

COPY config/php-fpm.conf /usr/local/etc/

#add custom php.ini
# COPY config/php.ini /usr/local/etc/php/
COPY config/xdebug.ini /usr/local/etc/php/conf.d

# Setup Volume
VOLUME ["/var/www/"]

#Set Workdir
WORKDIR /var/www/

#Add entrypoint
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]

