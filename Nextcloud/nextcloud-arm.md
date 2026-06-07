# Nextcloud ARM64

Nextcloud als selbst gehostete Cloud-Lösung auf ARM64-Geräten (Raspberry Pi, Apple Silicon).
Das `fpm-alpine`-Image nutzt PHP-FPM statt Apache — kleiner, ressourcenschonender, aber ohne eingebauten Webserver.

## Image

```
arm64v8/nextcloud:33.0-fpm-alpine
```

**fpm-alpine** bedeutet:
- `fpm` — PHP FastCGI Process Manager, kein Apache enthalten
- `alpine` — minimales Alpine-Linux-Basis-Image (~5 MB statt ~150 MB)

Ein vorgelagerter Webserver (nginx) muss PHP-Anfragen per FastCGI an den FPM-Prozess weiterleiten.

## Volumes

| Volume | Pfad im Container | Inhalt |
|--------|------------------|--------|
| `nextcloud-core` | `/var/www/html` | Nextcloud-PHP-Dateien und Templates |
| `nextcloud-apps` | `/var/www/html/custom_apps` | Manuell installierte Apps |
| `nextcloud-config` | `/var/www/html/config` | `config.php` mit DB- und Server-Einstellungen |
| `nextcloud-data` | `/var/www/html/data` | Nutzerdateien und Uploads |

`nextcloud-data` sollte auf ein Volume mit ausreichend Speicher zeigen — bei größeren Installationen Bind Mount auf externe Festplatte empfehlenswert:

```bash
-v /mnt/external/nextcloud-data:/var/www/html/data
```

## Starten

```bash
./start-arm64.sh
```

Web-UI erreichbar unter http://localhost:8080 (nach nginx-Konfiguration).

## Nginx als Reverse Proxy

Da das FPM-Image keinen Webserver enthält, muss nginx HTTP-Anfragen an PHP-FPM weiterleiten.
Minimale nginx-Konfiguration:

```nginx
server {
    listen 80;
    root /var/www/html;
    index index.php;

    location ~ \.php$ {
        fastcgi_pass nextcloud:9000;   # Container-Name:FPM-Port
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

## Hinweise

- Beim ersten Start richtet Nextcloud sich selbst ein — Datenbank und Admin-Zugangsdaten im Browser eingeben
- SQLite reicht für Einzelnutzer; für mehrere Nutzer MariaDB/PostgreSQL verwenden
- `nextcloud-config` und `nextcloud-data` niemals löschen — enthalten alle Einstellungen und Dateien
