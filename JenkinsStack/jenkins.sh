#!/bin/bash
# Startet den Jenkins Master Container.
# Jenkins ist ein quelloffener Automatisierungsserver für CI/CD-Pipelines.
#
# Port:    8080  – Jenkins Web-UI
# Port:    50000 – JNLP-Port für eingehende Agent-Verbindungen
# Volume:  Benanntes Docker Volume 'jenkins_home' für persistente Jenkins-Heimdaten
#          (Jobs, Plugins, Credentials, Build-Verlauf).
#          Wird automatisch erstellt, falls es noch nicht existiert.
# Neustart: Automatisch, außer bei manuellem Stopp

docker volume create jenkins_home

docker run --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -d \
  --restart unless-stopped \
  jenkins/jenkins:lts
