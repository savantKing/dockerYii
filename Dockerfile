# Import the docker container from Debian with LAMP 5.6
FROM php:5.6-apache

# System and Environment Instructions

RUN apt-get update && \
    apt-get install -y -qq software-properties-common

RUN apt-get install -y -qq wget git lynx ack-grep

RUN a2enmod rewrite

RUN docker-php-ext-install pdo pdo_mysql

# App Specific Instructions

RUN rm -rf /var/www/html && \
    mkdir /opt/app && \
    ln -s /opt/app /var/www/html
COPY src/. /opt/app/.

WORKDIR /opt/app

RUN wget -O ./composer https://getcomposer.org/download/1.4.2/composer.phar && \
    chmod +x ./composer

RUN ./composer install --no-dev

RUN echo 'alias ll="ls -la --color=auto"' >> ~/.bashrc && \
    echo "alias ack='ack-grep'" >> ~/.bashrc

RUN chown www-data:www-data -R ./

VOLUME ./src /opt/app
EXPOSE 80

CMD ["apache2", "-DFOREGROUND", "-k", "start"]