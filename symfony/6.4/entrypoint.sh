#!/bin/bash
set -e

composer install --prefer-dist --optimize-autoloader --no-interaction

php bin/console doctrine:migrations:migrate --allow-no-migration --no-interaction --env=prod --no-debug
php bin/console asset-map:compile --no-interaction --env=prod --no-debug
php bin/console cache:clear --no-interaction --env=prod --no-debug
php bin/console cache:warmup --no-interaction --env=prod --no-debug

chown -R user:group /var/www/html /var/log/apache2

su user

exec "$@"
