FROM composer:2.8 AS dependencies

WORKDIR /app

COPY sdk-game/composer.json sdk-game/composer.lock ./

RUN composer install \
    --no-dev \
    --prefer-dist \
    --no-interaction \
    --no-progress \
    --optimize-autoloader \
    --no-scripts


FROM php:8.4-cli-alpine AS runtime

RUN apk add --no-cache \
        freetype \
        libjpeg-turbo \
        libpng \
        libzip \
        oniguruma \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        freetype-dev \
        libjpeg-turbo-dev \
        linux-headers \
        libpng-dev \
        libzip-dev \
        oniguruma-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" \
        gd \
        mbstring \
        pdo_mysql \
        sockets \
        zip \
    && apk del .build-deps

RUN addgroup -S app && adduser -S -G app app

WORKDIR /var/www/html

COPY --chown=app:app sdk-game/ ./
COPY --from=dependencies --chown=app:app /app/vendor ./vendor

RUN mkdir -p storage bootstrap/cache \
    && rm -f bootstrap/cache/*.php \
    && chown -R app:app storage bootstrap/cache

USER app

EXPOSE 8080

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
