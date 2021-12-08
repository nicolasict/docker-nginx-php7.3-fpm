FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
# Install tool pendukung
RUN apt-get update
RUN apt-get install -y sudo
RUN apt-get install -y curl wget nano htop
RUN apt-get install -y software-properties-common
RUN apt-get install -y redis-tools
RUN apt-get install -y mysql-client
RUN apt-get install -y postgresql-client
RUN apt-get install -y vim
RUN add-apt-repository ppa:ondrej/php
RUN apt-get install -y apt-utils
# Install NGINX
RUN apt-get install -y nginx
# Install PHP 7.3-FPM
RUN apt-get install -y php7.3-fpm
RUN apt-get install -y php7.3-curl \
        php7.3-gmp \
        php7.3-mysql \
        php7.3-pgsql\
        php7.3-common \
        php7.3-cli \
        php7.3-gd \
        php7.3-opcache \
        php7.3-imagick \
        php7.3-mbstring \
        php7.3-xml \
        php7.3-zip \
        php7.3-redis \
        php7.3-gettext \
        php7.3-ctype \
        php7.3-tokenizer \
        php7.3-json \
        php7.3-MySqli \
        php7.3-MySqlND \
        php7.3-pdo 
# Install Commposer
RUN apt install -y curl php7.3-cli php7.3-mbstring git unzip
RUN curl –sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
# Install SSH Server
RUN apt-get install -y openssh-server
# Install Git
RUN apt-get install -y git-core
# Install NPM + NodeJS
RUN cd /home/ && curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN cd /home/ && chmod +x nodesource_setup.sh 
RUN cd /home/ && ./nodesource_setup.sh
RUN apt update && apt install -y nodejs
# Konfigurasi NGINX + PHP
RUN echo "<?php phpinfo();?>" >> /var/www/html/info.php
RUN mkdir /etc/nginx/ssl/
COPY config/default /etc/nginx/sites-enabled/
# Config by Script
ADD config  /config
RUN chmod -R +x /config

WORKDIR /var/www/html
ENTRYPOINT /config/runner.sh && /bin/bash
