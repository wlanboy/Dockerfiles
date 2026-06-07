# Startet Nextcloud für ARM64 (z.B. Raspberry Pi).
# FPM-Variante: PHP-FPM statt Apache — benötigt einen separaten Webserver (z.B. nginx) als Reverse Proxy.
# Volumes müssen vorab nicht angelegt werden — Docker erstellt sie automatisch beim ersten Start.

# Volumes anlegen (idempotent)
docker volume create nextcloud-core
docker volume create nextcloud-apps
docker volume create nextcloud-config
docker volume create nextcloud-data

docker run -d --name nextcloud \
    -p 8080:80 \
    -v nextcloud-core:/var/www/html \          # Nextcloud-Core-Dateien (PHP, Templates)
    -v nextcloud-apps:/var/www/html/custom_apps \  # Manuell installierte Apps
    -v nextcloud-config:/var/www/html/config \     # Konfiguration (config.php)
    -v nextcloud-data:/var/www/html/data \         # Nutzerdaten (Dateien, Uploads)
    arm64v8/nextcloud:33.0-fpm-alpine
