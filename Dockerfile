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
    && docker-php-ext-install intl zip pdo pdo_pgsql gd

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY . .

RUN composer install --no-dev --optimize-autoloader

CMD ["php-fpm"]
