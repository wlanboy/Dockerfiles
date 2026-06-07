#!/bin/bash
# Startet einen MariaDB Container, der nur lokal erreichbar ist (kein Netzwerkzugriff von außen).
#
# Port:      3306, gebunden an 127.0.0.1 (nur localhost)
# Volume:    Benanntes Docker Volume 'mariadb_data' für persistente Datenbankdaten.
#            Wird automatisch erstellt, falls es noch nicht existiert.
# Datenbank: 'spring' mit gleichnamigem Benutzer
# Neustart:  Automatisch, außer bei manuellem Stopp

docker volume create mariadb_data

docker run --name mariadb \
  -p 127.0.0.1:3306:3306 \
  -v mariadb_data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=spring \
  -e MYSQL_USER=spring \
  -e MYSQL_PASSWORD=spring \
  -d \
  --restart unless-stopped \
  mariadb:12-ubi10
