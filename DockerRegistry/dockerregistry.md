# Docker Registry

Private Docker Registry mit htpasswd-Authentifizierung. Läuft auf Port 5000.

## Setup

Einmalige Initialisierung vor dem ersten Start — Benutzer anlegen, dann Registry starten.

```bash
./pwd.sh
docker compose up -d
```

## Images pushen und pullen

Image aus Docker Hub holen, für die eigene Registry umtaggen und hochladen.

```bash
docker pull ubuntu:24.04
docker tag ubuntu:24.04 localhost:5000/ubuntu
docker push localhost:5000/ubuntu
```

Von der eigenen Registry pullen:

```bash
docker pull localhost:5000/ubuntu
```

Von extern (mit Hostname statt localhost):

```bash
docker pull myregistry.domain.com:5000/ubuntu
```

## Anmelden

Credentials aus `./auth/registry.password` werden abgefragt.

```bash
docker login localhost:5000
```

## Weiteren Benutzer hinzufügen

`-c` weglassen damit die bestehende Passwort-Datei nicht überschrieben wird.

```bash
htpasswd -B ./auth/registry.password neuer-user
```

## TLS aktivieren (optional)

Verschlüsselter Zugriff über HTTPS — nötig für externe Registries ohne `--insecure-registry`.

Zertifikate ins `certs/`-Verzeichnis legen und in `docker-compose.yml` ergänzen:

```yaml
environment:
  REGISTRY_HTTP_TLS_CERTIFICATE: /certs/domain.crt
  REGISTRY_HTTP_TLS_KEY: /certs/domain.key
volumes:
  - ./certs:/certs
```
