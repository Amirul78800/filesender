#!/bin/bash
set -e

# Jika config.php belum wujud, cipta dari config.default.php
if [ ! -f /var/www/html/config/config.php ]; then
    if [ -f /var/www/html/config/config.default.php ]; then
        cp /var/www/html/config/config.default.php /var/www/html/config/config.php
        echo "✅ Config file created from config.default.php"
    else
        echo "⚠️ Warning: config.default.php not found!"
    fi
fi

# Cipta direktori yang diperlukan
mkdir -p /var/www/html/data/files /var/www/html/tmp

# Set permissions yang betul
chown -R www-data:www-data /var/www/html/config /var/www/html/data /var/www/html/tmp
chmod -R 755 /var/www/html
chmod -R 775 /var/www/html/config /var/www/html/data /var/www/html/tmp

# Betulkan DocumentRoot ke folder www
sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/www|g' /etc/apache2/sites-available/000-default.conf
sed -i 's|<Directory /var/www/html>|<Directory /var/www/html/www>|g' /etc/apache2/sites-available/000-default.conf

echo "✅ FileSender container ready"
echo "🌐 Access at http://localhost:80"

exec "$@"
