#!/bin/bash
# Startet einen PostgreSQL 16.1 Container auf ARM64-Systemen (z. B. Raspberry Pi, Apple M1/M2).
#
# Volumes:       Benanntes Docker Volume 'postgresdata' für persistente Datenbankdateien.
#                Wird automatisch erstellt, falls es noch nicht existiert.
# Initialisierung: postgres.sql wird beim ersten Start als Init-Skript ausgeführt.
# Neustart:     Der Container startet automatisch neu, außer er wurde manuell gestoppt.

docker volume create postgresdata

docker run --name postgres \
  -d \
  -p 5432:5432 \
  -v postgresdata:/var/lib/postgresql/data \
  -v $PWD/postgres.sql:/docker-entrypoint-initdb.d/init.sql \
  -e POSTGRES_PASSWORD=spring \
  -e POSTGRES_USER=spring \
  -e POSTGRES_DB=spring \
  --restart unless-stopped \
  arm64v8/postgres:16.1-alpine
