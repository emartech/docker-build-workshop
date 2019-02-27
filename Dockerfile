FROM ubuntu:18.04

ARG NPM_TOKEN
ENV DEBIAN_FRONTEND=noninteractive
ENV CACHE_BUSTER=0

COPY . /app

RUN apt-get update
RUN apt-get install -y \
    curl \
    gnupg2 \
    php-cli \
    php-mbstring \
    php-xml \
    git \
    unzip \
    nano \
  && curl -sL https://deb.nodesource.com/setup_11.x | bash - \
  && apt-get update \
  && apt-get install -y nodejs
RUN rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN cd /app \
  && composer install

RUN cd app \
  && npm install \
  && npm run build

EXPOSE 9000

CMD php -S 0.0.0.0:9000 -t /app/public