#!/bin/bash
# Startet einen Valkey Container auf amd64/x86_64-Systemen.
# Valkey ist ein Open-Source-Fork von Redis (https://github.com/valkey-io/valkey).
#
# Port:      6379 (RESP-Protokoll, kompatibel mit Redis-Clients)
# RAM-Limit: 512 MB
# Volume:    Benanntes Docker Volume 'valkey_data' für persistente Daten.
#            Wird automatisch erstellt, falls es noch nicht existiert.
# Neustart:  Der Container startet automatisch neu, außer er wurde manuell gestoppt.

docker volume create valkey_data

docker run --name valkey \
  -m 512MB \
  -p 6379:6379 \
  -v valkey_data:/data \
  --restart unless-stopped \
  -d \
  valkey/valkey:8-alpine \
  valkey-server
