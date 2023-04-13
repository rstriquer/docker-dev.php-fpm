# PHP-FPM docker image with composer

`ready for laravel and cakePHP frameworks `

## Info

- Based on php:8.2-fpm-alpine3.17 official Image [php:8.2-fpm-alpine3.17](https://hub.docker.com/_/php/)

## Build

For example, if you need to install or remove php extensions, edit the Dockerfile and than build-it.

    git clone git@github.com:camilb/docker-php-fpm.git
    cd ./docker-php-fpm
    git checkout 8.2-dev
    docker build --no-cache --rm -t rstriquer/php-fpm.dev:8.2-dev .

## Usage

    docker pull rstriquer/php-fpm.dev:8.2-dev
    docker run --rm -d rstriquer/php-fpm.dev:8.2-dev
