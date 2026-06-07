# Gitea Docker Setup

Dieses Verzeichnis enthält ein Skript zum Starten einer selbst gehosteten Gitea-Instanz via Docker. Gitea ist ein leichtgewichtiger, quelloffener Git-Dienst mit Web-UI, Issue-Tracker, Pull-Request-Workflow und CI/CD-Integration. Er eignet sich besonders für den Heimserver- und Intranet-Einsatz.

## Dateien

| Datei | Beschreibung |
|---|---|
| `start.sh` | Startet den Gitea Container |

## Konfiguration

| Parameter | Wert |
|---|---|
| Image | `gitea/gitea:latest` |
| Container-Name | `gitea` |
| Web-UI Port | `3000` |
| SSH-Port | `8022` (Host) → `22` (Container) |
| Domain | `gmk.lan` |
| Root-URL | `http://gmk.lan:3000` |
| Volume | `/giteadata` (Host-Pfad) |
| Neustart-Richtlinie | `unless-stopped` |

## Verwendung

```bash
chmod +x start.sh
./start.sh
```

Gitea ist danach unter `http://gmk.lan:3000` erreichbar. Beim ersten Aufruf öffnet sich der Setup-Assistent zur Einrichtung der Datenbank und des Admin-Kontos.

## Git-Zugriff

```bash
# Repository per HTTP klonen
git clone http://gmk.lan:3000/user/repo.git

# Repository per SSH klonen (Host-Port 8022)
git clone ssh://git@gmk.lan:8022/user/repo.git
```

SSH-Schlüssel können in der Web-UI unter **User Settings → SSH / GPG Keys** hinterlegt werden.

## Zeitzone

Die Zeitzone des Hosts wird über zwei Bind Mounts in den Container übernommen:
- `/etc/timezone` — Zeitzonenname (z.B. `Europe/Berlin`)
- `/etc/localtime` — Binäre Zeitzonendaten

Damit werden Commit-Zeitstempel und UI-Anzeigen in der lokalen Zeit dargestellt.

## Hinweise

- Zum Stoppen: `docker stop gitea`
- Zum Entfernen: `docker rm gitea`
- Logs einsehen: `docker logs gitea`
- Konfigurationsdatei im Container: `/data/gitea/conf/app.ini`
