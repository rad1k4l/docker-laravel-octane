FROM php:7.4-fpm-alpine

# Install laravel requirement PHP package
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS libzip-dev sqlite-dev \
            libpng-dev libxml2-dev oniguruma-dev libmcrypt-dev curl curl-dev libcurl postgresql-dev
RUN docker-php-ext-install -j$(nproc) gd bcmath zip pdo_mysql pdo_pgsql
RUN pecl install  xdebug swoole && docker-php-ext-enable  swoole

# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

EXPOSE 1215

CMD php artisan swoole:http start

