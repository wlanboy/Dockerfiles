# Artifactory OSS Docker Setup

Dieses Verzeichnis enthält ein Skript zum Starten von JFrog Artifactory Open Source via Docker. Artifactory ist ein universeller Artefakt-Repository-Manager, der Maven-, Gradle-, npm-, Docker- und weitere Paketformate unterstützt. Er dient als lokaler Spiegel für externe Repositories und als internes Ablagesystem für Build-Artefakte.

## Dateien

| Datei | Beschreibung |
|---|---|
| `run.sh` | Startet den Artifactory OSS Container |

## Konfiguration

| Parameter | Wert |
|---|---|
| Image | `docker.bintray.io/jfrog/artifactory-oss:latest` |
| Container-Name | `artifactory` |
| Port | `8081` (Web-UI und Repository-API) |
| JVM Heap | Min `512m`, Max `2g` |
| JVM Stack | `256k` per Thread |
| GC | G1GC |
| Neustart-Richtlinie | – (kein `--restart`) |

## Verwendung

```bash
chmod +x run.sh
./run.sh
```

Die Web-UI ist danach unter `http://localhost:8081` erreichbar.
Standard-Zugangsdaten: `admin` / `password` (beim ersten Login ändern).

## Maven-Konfiguration

Artifactory als lokalen Maven-Mirror einbinden (`~/.m2/settings.xml`):

```xml
<settings>
  <mirrors>
    <mirror>
      <id>artifactory</id>
      <mirrorOf>*</mirrorOf>
      <url>http://localhost:8081/artifactory/libs-release</url>
    </mirror>
  </mirrors>
  <servers>
    <server>
      <id>artifactory</id>
      <username>admin</username>
      <password>password</password>
    </server>
  </servers>
</settings>
```

## Hinweise

- Zum Stoppen: `docker stop artifactory`
- Zum Entfernen: `docker rm artifactory`
- Logs einsehen: `docker logs artifactory`
- Ohne Volume gehen alle hochgeladenen Artefakte beim Container-Entfernen verloren
