# InfluxDB 3 Core

Zeitreihendatenbank für Metriken und Monitoring. Läuft auf Port 8181.

## Token-Datei offline erzeugen

Admin-Token vor dem ersten Start vorbereiten — ohne laufende InfluxDB-Instanz.

```bash
influxdb3 create token --admin \
  --name TOKEN_NAME \
  --expiry DURATION \
  --offline \
  --output-file path/to/admin-token.json
```

Format der erzeugten Datei:

```json
{
  "token": "apiv3_0XXXX-xxxXxXxxxXX_OxxxX...",
  "name": "_admin",
  "description": "Admin token for InfluxDB 3",
  "expiry_millis": 1756400061529
}
```

Hinweise:
- Token muss mit `apiv3_` beginnen
- Dateiberechtigung auf `0600` setzen
- Wenn kein Token konfiguriert ist, erstellt der Server beim Start automatisch einen

## InfluxDB mit Token-Datei starten

Token beim Serverstart einbinden — per Argument oder Umgebungsvariable.

Via Argument:

```bash
influxdb3 serve --admin-token-file path/to/admin-token.json
```

Via Umgebungsvariable:

```bash
INFLUXDB3_ADMIN_TOKEN_FILE=path/to/admin-token.json influxdb3 serve
```

## Docker Compose: Token als Secret einbinden

Sicherer als Bind Mount — Secrets werden verschlüsselt im Speicher gehalten und sind in `docker inspect` nicht sichtbar.

```yaml
services:
  influxdb3-core:
    image: influxdb:3-core
    secrets:
      - admin-token

secrets:
  admin-token:
    file: ./admin-token.json
```
