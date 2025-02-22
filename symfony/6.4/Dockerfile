FROM php:8.1-apache

ARG APT_PACKAGES
ARG PHP_EXTENSIONS
ARG GROUP_ID
ARG USER_ID

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends $APT_PACKAGES && \
    docker-php-ext-install $PHP_EXTENSIONS && \
    rm -rf /var/lib/apt/lists/* && \
    a2enmod rewrite && \
    groupadd -g $GROUP_ID group && \
    useradd -u $USER_ID -g group user && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["apache2-foreground"]
