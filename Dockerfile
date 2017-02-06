# basti1253/alpine-php
FROM alpine:edge

MAINTAINER Sebastian Sauer <info@dynpages.de>

ENV REFRESHED_AT="2016-02-06" \
  TIMEZONE=Europe/Berlin \
  USERNAME=php \
  USERID=1000 \
  MAX_UPLOAD=2000M \
  PHP_MEMORY_LIMIT=128M \
  PHP_MAX_FILE_UPLOAD=200 \
  PHP_MAX_POST=2100M \
  TERM=xterm-256color

RUN	apk update \
  && apk upgrade \
  && apk add --update \
    shadow \
    tzdata \
    bash \
    php7-fpm \
    php7-common \
    php7-mcrypt \
    php7-intl \
    php7-session \
    php7-sockets \
    # dbas
    php7-mysqli \
    php7-sqlite3 \
    php7-pdo \
    php7-pdo_pgsql \
    php7-pdo_mysql \
    php7-pdo_sqlite \
    # DOM/XML
    php7-dom \
    php7-xml \
    php7-xmlreader \
    php7-xsl \
    ## images
    php7-gd \
    ## other
    php7-phar \
    php7-curl \
    php7-soap \
    php7-zip \
    php7-json \
    php7-bcmath \
    php7-gettext \
    php7-bz2 \
    php7-iconv \
  && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
  && echo "${TIMEZONE}" > /etc/timezone \
  && sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf \
  && sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i "s|;*listen\s*=\s*/||g" /etc/php7/php-fpm.d/www.conf \
  && sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini \
  && sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini \
  && sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini \
  && sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini \
  && sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini \
  && sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini \
  && sed -i "s|user =.*|user = ${USERNAME}|i" /etc/php7/php-fpm.d/www.conf \
  && sed -i "s|group =.*|group = ${USERNAME}|i" /etc/php7/php-fpm.d/www.conf \
  && apk del tzdata \
  && rm -rf /var/cache/apk/* \
  && mkdir /var/www;

RUN groupadd --gid $USERID $USERNAME \
  && useradd --uid $USERID --gid $USERID --shell /bin/bash $USERNAME \
  && chown -R $USERNAME /var/log/php7/ \
  && chown -R $USERNAME /var/www/

WORKDIR /var/www

VOLUME ["/var/www"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7"]
