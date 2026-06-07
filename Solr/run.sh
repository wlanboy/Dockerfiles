#!/bin/bash
# Startet einen Solr-Server als Docker-Container.
#
# --name solr-server        Containername für einfache Verwaltung
# --restart unless-stopped  Automatischer Neustart außer bei manuellem Stopp
# -d                        Hintergrundmodus (detached)
# -p 8983:8983              Solr Web-UI und API (Host:Container)
# -t                        Pseudo-TTY für bessere Log-Ausgabe
# -v /mydata:/opt/solr/mydata  Persistentes Datenverzeichnis für Cores und Indizes
docker run --name solr-server --restart unless-stopped -d -p 8983:8983 -t \
  -v /mydata:/opt/solr/mydata \
  solr:10-slim
