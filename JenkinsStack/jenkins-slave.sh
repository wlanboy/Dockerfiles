#!/bin/bash
# Startet den Jenkins Build-Agent (Slave) als Container.
# Der Agent verbindet sich per JNLP mit dem Jenkins Master und führt dort
# registrierte Jobs aus. Docker-in-Docker wird über den Host-Socket ermöglicht.
#
# Docker-Socket:    /var/run/docker.sock (Bind Mount – ermöglicht Docker-Befehle im Build)
# Agent-Workdir:    Benanntes Volume 'jenkins_agent' – persistiert Workspace zwischen Builds
# Maven-Cache:      Benanntes Volume 'jenkins_m2'    – vermeidet wiederholte Dependency-Downloads
# Master-URL:       http://nuc:8080
# Agent-Name:       javaworker
# Arbeitsverzeichnis: /home/jenkins/agent
# Neustart: Automatisch, außer bei manuellem Stopp
#
# Hinweis: Das 'secret' wird im Jenkins Master unter
#   Manage Jenkins → Nodes → javaworker → Agent → Secret angezeigt.

docker volume create jenkins_agent
docker volume create jenkins_m2

docker run --name jenkins-slave \
  -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_agent:/home/jenkins/agent \
  -v jenkins_m2:/root/.m2 \
  --restart unless-stopped \
  wlanboy/jenkins-docker-openjdk21-slave \
  -url http://nuc:8080 \
  -workDir=/home/jenkins/agent \
  secret javaworker
