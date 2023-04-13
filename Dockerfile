# Build php8.2-fpm from alpine package
# To build just run: docker build --no-cache --rm --build-arg user=$USER --build-arg uid=$UID --build-arg gid=$UID -t rstriquer/php-fpm.dev:8.2-dev .
# @todo install imagick and/or jd
# @see https://laracasts.com/discuss/channels/laravel/install-imagemagick-on-docker
# RUN apt-get install -y ghostscript;
# RUN apt-get install -y libmagickwand-dev --no-install-recommends

FROM php:8.2-fpm-alpine3.17

ARG user=docker
ARG uid=1000
ARG gid=1000

ENV XDEBUG_MODE=debug,trace
ENV XDEBUG_CONFIG=""

RUN echo "UTC" > /etc/timezone
RUN addgroup -g $gid $user && \
    adduser --disabled-password --gecos "" -G $user -u $uid -h /home/$user $user
RUN apk add --no-cache --update bash linux-headers
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

RUN set -xe && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS
RUN set -xe && apk add --no-cache --update --virtual zip unzip curl npm \
    autoconf g++ libtool make icu-dev
RUN pecl install redis && docker-php-ext-enable redis
RUN docker-php-ext-install pdo_mysql opcache pcntl bcmath
RUN pecl install xdebug && docker-php-ext-enable xdebug

COPY --from=composer:2.5.5 /usr/bin/composer /usr/bin/composer

RUN apk del autoconf bash binutils file g++ gcc gmp libatomic libbz2 libc-dev \
    libgcc libgomp libltdl libmagic libstdc++ libtool m4 make mpc1 musl-dev \
    perl pkgconf pkgconfig re2c readline sqlite-libs
RUN rm -rf /tmp/* /var/cache/apk/*

# Setup Volume
VOLUME ["/var/www/"]

#Set Workdir
WORKDIR /var/www/

USER $user

EXPOSE 9000
EXPOSE 9003

CMD ["php-fpm"]
