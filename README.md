# PHP-FPM docker image with composer


```ready for laravel and cakePHP frameworks ```


## Info

* Based on php:7.3-fpm official Image [php:7.3-fpm](https://hub.docker.com/_/php/)
* Build upon [copeus/docker-php-fpm](https://github.com/copeus/docker-php-fpm) work


## Build

For example, if you need to install or remove php extensions, edit the Dockerfile and than build-it.

	git clone git@github.com:camilb/docker-php-fpm.git
	cd ./docker-php-fpm
    git checkout v7.3
	docker build --rm -t --no-cache rstriquer/php-fpm.dev:7.3 .

## Usage

	docker pull rstriquer/php-fpm.dev:7.3
	docker run --rm -d rstriquer/php-fpm.dev:7.3




