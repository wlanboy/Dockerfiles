# Jenkins mit Build-Agent (Docker-in-Docker)

Dieses Verzeichnis enthält Skripte und ein Dockerfile für einen Jenkins CI/CD-Stack bestehend aus einem Jenkins Master und einem angebundenen Build-Agent. Der Agent kann Docker-Befehle ausführen, da der Host-Docker-Socket eingebunden wird.

## Architektur

```
Jenkins Master  (Port 8080 / 50000)
      │
      │ JNLP (Port 50000)
      ▼
Jenkins Build-Agent
  + Docker CLI (via Host-Socket)
  + OpenJDK 21
  + Maven
```

## Dateien

| Datei | Beschreibung |
|---|---|
| `jenkins.sh` | Startet den Jenkins Master Container |
| `jenkins-slave.sh` | Startet den Build-Agent Container |
| `build-jenkins-slave.sh` | Baut das benutzerdefinierte Agent-Image lokal |
| `Dockerfile` | Definition des Agent-Images (jnlp-slave + Docker + Java + Maven) |

## Konfiguration

| Parameter | Wert |
|---|---|
| Master-Image | `jenkins/jenkins:lts` |
| Agent-Image | `wlanboy/jenkins-docker-openjdk21-slave` |
| Web-UI Port | `8080` |
| JNLP-Port | `50000` |
| Master-Volume | `jenkins_home` (benanntes Docker Volume) |
| Agent-Workdir-Volume | `jenkins_agent` (benanntes Docker Volume) |
| Maven-Cache-Volume | `jenkins_m2` (benanntes Docker Volume) |
| Agent-Name | `javaworker` |
| Master-URL im Agent | `http://nuc:8080` |

## Ersteinrichtung

### 1. Agent-Image bauen

```bash
chmod +x build-jenkins-slave.sh
./build-jenkins-slave.sh
```

### 2. Jenkins Master starten

```bash
chmod +x jenkins.sh
./jenkins.sh
```

Jenkins ist danach unter `http://localhost:8080` erreichbar.
Das initiale Admin-Passwort liegt im Volume:

```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

### 3. Agent in Jenkins registrieren

1. Jenkins-UI öffnen → **Manage Jenkins → Nodes → New Node**
2. Node-Name: `javaworker`, Typ: Permanent Agent
3. Verbindungsart: **Launch agent by connecting it to the controller**
4. Das generierte Secret notieren

### 4. Agent-Container starten

Das Secret aus Schritt 3 in `jenkins-slave.sh` eintragen, dann:

```bash
chmod +x jenkins-slave.sh
./jenkins-slave.sh
```

## Docker-in-Docker

Der Agent bindet den Host-Docker-Socket ein (`/var/run/docker.sock`). Dadurch können Jenkins-Pipelines Docker-Images bauen und Container starten, ohne einen separaten Docker-Daemon zu betreiben.

```groovy
// Beispiel Jenkinsfile
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'mvn -q package'
                sh 'docker build -t myapp .'
            }
        }
    }
}
```

## Hinweise

- Zum Stoppen: `docker stop jenkins jenkins-slave`
- Zum Entfernen: `docker rm jenkins jenkins-slave`
- Logs einsehen: `docker logs jenkins` / `docker logs jenkins-slave`
- Die Volumes überleben Container-Neustarts und -Entfernungen.

| Volume | Inhalt |
|---|---|
| `jenkins_home` | Jenkins-Konfiguration, Jobs, Plugins, Credentials |
| `jenkins_agent` | Build-Workspaces des Agents (persistiert zwischen Builds) |
| `jenkins_m2` | Maven-Dependency-Cache (vermeidet wiederholte Downloads) |

```bash
# Volumes manuell einsehen
docker volume inspect jenkins_home jenkins_agent jenkins_m2

# Volumes löschen (Achtung: Konfiguration und Cache gehen verloren)
docker volume rm jenkins_home jenkins_agent jenkins_m2
```
