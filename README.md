# PHP-FPM docker image with composer

`ready for laravel and cakePHP frameworks `

## Info

- Based on php:8.2-fpm-alpine3.17 official Image [php:8.2-fpm-alpine3.17](https://hub.docker.com/_/php/)

## Build

For example, if you need to install or remove php extensions, edit the Dockerfile and than build-it.

**IMPORTANT**: If you are using windows or any other non unix-like environment
you need to figure out what username, user id and group id to set on the build
command bellow.

    git clone git@github.com:camilb/docker-php-fpm.git
    cd ./docker-php-fpm
    git checkout 8.2-dev
    docker build --no-cache --rm --build-arg user=$USER --build-arg uid=$UID --build-arg gid=$UID -t rstriquer/php-fpm.dev:8.2-dev .

## Usage

    docker pull rstriquer/php-fpm.dev:8.2-dev
    docker run --rm -d rstriquer/php-fpm.dev:8.2-dev

PS: The default working directory is '/var/www/'
