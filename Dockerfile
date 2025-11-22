FROM php:8.3-fpm AS app

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libzip-dev \
    libpng-dev \
    tesseract-ocr \
    libtesseract-dev \
    libpq-dev \
    && docker-php-ext-install intl zip gd \
    && docker-php-ext-install pdo pdo_pgsql

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY . .

RUN composer install --optimize-autoloader

CMD ["php-fpm"]
