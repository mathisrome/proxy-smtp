FROM php:8.3-fpm

## Configuration de la Timezone en France
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

## PHP Extensions & Composer
RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    && chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions gd \
        exif \
        pdo_mysql \
        intl \
        zip \
        bcmath \
        @composer

## DEV KIT
COPY devkit.sh /tmp/devkit.sh
RUN bash /tmp/devkit.sh

## ENV Configuration grumphp
ENV PATH="/root/.composer/vendor/bin:${PATH}"
ENV GRUMPHP_PROJECT_DIR=/workspace/app
ENV GRUMPHP_GIT_WORKING_DIR=/workspace
ENV GRUMPHP_COMPOSER_DIR=/workspace/app

## Project Config
COPY project.ini /usr/local/etc/php/conf.d/project.ini

WORKDIR /app