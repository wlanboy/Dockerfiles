#!/bin/bash
# Startet einen MariaDB Container in einem benutzerdefinierten Docker-Netzwerk.
# Init-SQL-Skripte werden beim ersten Start automatisch ausgeführt.
#
# Port:      3306 (MySQL-Protokoll)
# Netzwerk:  'xpoint' (benutzerdefiniertes Docker-Netzwerk)
# Volume:    Benanntes Docker Volume 'mariadb_data' für persistente Datenbankdaten.
#            Wird automatisch erstellt, falls es noch nicht existiert.
# Init:      SQL-Skripte aus /home/wlanboy/scripts/ werden beim ersten Start ausgeführt
# Datenbank: 'spring' mit gleichnamigem Benutzer
# Neustart:  Automatisch, außer bei manuellem Stopp

docker volume create mariadb_data

docker run --name mariadb \
  -p 3306:3306 \
  -v mariadb_data:/var/lib/mysql \
  --net=xpoint \
  --mount type=bind,src=/home/wlanboy/scripts/,dst=/docker-entrypoint-initdb.d/ \
  -e MYSQL_ROOT_PASSWORD=spring \
  -e MYSQL_DATABASE=spring \
  -e MYSQL_USER=spring \
  -e MYSQL_PASSWORD=spring \
  -d \
  --restart unless-stopped \
  mariadb:12-ubi10
