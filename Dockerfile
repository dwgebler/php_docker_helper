ARG PHPVERSION=7.4
FROM php:$PHPVERSION-apache-buster
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql
COPY ./certs/localhost.key ./certs/localhost.crt ./certs/ca.crt /etc/apache2/ssl/
COPY ./apache/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY ./apache/localhost.conf /etc/apache2/sites-available/localhost-ssl.conf
RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load && ln -s /etc/apache2/sites-available/localhost-ssl.conf /etc/apache2/sites-enabled/localhost-ssl.conf
