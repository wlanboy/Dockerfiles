#!/bin/bash
# Baut das benutzerdefinierte Jenkins-Agent-Image lokal.
# Das Image basiert auf jenkins/jnlp-slave und enthält zusätzlich:
# Docker CLI, OpenJDK 21 und Maven.
#
# Ergebnis-Image: wlanboy/jenkins-docker-openjdk21-slave
# Muss vor dem ersten Start von jenkins-slave.sh ausgeführt werden.

docker build -t wlanboy/jenkins-docker-openjdk21-slave .
