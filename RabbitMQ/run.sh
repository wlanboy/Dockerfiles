#!/bin/bash
# Startet einen RabbitMQ 3.8.2 Container auf amd64/x86_64-Systemen.
#
# Management-UI: Erreichbar unter http://localhost:15672 (Standardzugangsdaten: guest/guest)
# AMQP:          Port 5672 (unverschlüsselt), Port 5671 (TLS)
# Hostname:      Wird auf 'nuc' gesetzt – wichtig für die RabbitMQ-Node-Identität bei Clustering.
# Hinweis:       Kein Volume definiert – Daten gehen beim Löschen des Containers verloren.

docker volume create rabbitmq_data

docker run -d \
  --name rabbitmq \
  -p 15672:15672 \
  -p 5672:5672 \
  -p 5671:5671 \
  --hostname nuc \
  -v rabbitmq_data:/var/lib/rabbitmq \
  rabbitmq:3.8.2-management
