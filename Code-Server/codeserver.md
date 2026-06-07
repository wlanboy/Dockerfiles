# Code-Server

Browser-basierte VS Code Instanz. Erreichbar unter http://localhost:9000

## Authentifizierung

Zugriffsschutz konfigurieren — standardmäßig Passwort, in `run.sh` deaktiviert.

Standardmäßig ist Passwort-Auth aktiv. Das Passwort steht in `~/.config/code-server/config.yaml` im Container.

Auth deaktivieren (wie in `run.sh` konfiguriert):

```bash
--auth none
```

Passwort setzen (alternativ zu `--auth none`):

```yaml
# ~/.config/code-server/config.yaml
auth: password
password: meinpasswort
```

Rate Limiting ist eingebaut: max. 2 Versuche/Minute + 12/Stunde.

## Wichtige Flags

Übersicht der häufig genutzten Startparameter.

| Flag | Beschreibung |
|------|-------------|
| `--auth none` | Authentifizierung deaktivieren |
| `--disable-telemetry` | Keine Nutzungsdaten senden |
| `--cert` | Self-signed TLS aktivieren |
| `--bind-addr 0.0.0.0:8080` | Bind-Adresse ändern |

## Interne Services proxyen

Über code-server auf laufende Services im Container zugreifen, ohne extra Port freizugeben.

- `/proxy/<port>/` — Pfad wird abgeschnitten (Trailing Slash nötig)
- `/absproxy/<port>/` — Absoluter Pfad bleibt erhalten

## Reverse Proxy (NGINX)

Pflicht-Header damit WebSockets (Terminal, Live Share) korrekt funktionieren.

```nginx
proxy_set_header Host $http_host;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection upgrade;
```
