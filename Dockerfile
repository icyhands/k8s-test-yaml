FROM ubuntu:20.04

RUN apt-get update

# PHP_INI_DIR to be symmetrical with official php docker image
# Set Timezone
ENV PHP_INI_DIR /etc/php/7.4
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && echo Asia/Seoul > /etc/timezone

# When using Composer, disable the warning about running commands as root/super user
ENV COMPOSER_ALLOW_SUPERUSER=1

# Persistent runtime dependencies
ARG DEPS="\
        apache2 \
        php7.4 \
        php-phar \
        php-bcmath \
        php-calendar \
        php-mbstring \
        php-exif \
        php-ftp \
        php-zip \
        php-sysvsem \
        php-sysvshm \
        php-sysvmsg \
        php-shmop \
        php-sockets \
        php-bz2 \
        php-curl \
        php-simplexml \
        php-xml \
        php-opcache \
        php-dom \
        php-xmlreader \
        php-xmlwriter \
        php-tokenizer \
        php-ctype \
        php-mysql \
        php-fileinfo \
        php-iconv \
        php-json \
        php-posix \
        php-fpm \
        php-mysql \
        curl \
        ca-certificates \
        runit \
        lynx \
"

RUN set -x \
    && apt-get install -y $DEPS \
    && ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

WORKDIR /var/www/html
EXPOSE 80

CMD ["apachectl", "-DFOREGROUND"]
