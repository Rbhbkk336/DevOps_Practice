FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libicu-dev \
    libxml2-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    tesseract-ocr \
    tesseract-ocr-eng \
    && docker-php-ext-install intl pdo pdo_pgsql gd

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

COPY . .

RUN chown -R www-data:www-data /var/www/html

CMD ["php-fpm"]
