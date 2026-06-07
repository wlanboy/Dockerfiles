#!/bin/bash
# Startet einen MariaDB Container mit minimiertem Speicherverbrauch.
# Geeignet für Systeme mit wenig RAM (z.B. kleine VMs oder Einplatinenrechner).
#
# Port:      3306 (MySQL-Protokoll)
# Volume:    Benanntes Docker Volume 'mariadb_data' für persistente Datenbankdaten.
#            Wird automatisch erstellt, falls es noch nicht existiert.
# Config:    lowmemory.cnf (Bind Mount) überschreibt die Standard-MariaDB-Konfiguration
# Datenbank: 'spring' mit gleichnamigem Benutzer
# Neustart:  Automatisch, außer bei manuellem Stopp

docker volume create mariadb_data

docker run --name mariadb \
  -p 3306:3306 \
  -v mariadb_data:/var/lib/mysql \
  -v "$(pwd)/lowmemory.cnf":/etc/mysql/my.cnf \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=spring \
  -e MYSQL_USER=spring \
  -e MYSQL_PASSWORD=spring \
  -d \
  --restart unless-stopped \
  mariadb:12-ubi10
