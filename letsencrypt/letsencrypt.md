# Let's Encrypt

Kostenlose, automatisierte TLS-Zertifikate von der gemeinnützigen Certificate Authority Let's Encrypt.
Zertifikate sind 90 Tage gültig und können vollautomatisch über das ACME-Protokoll ausgestellt und erneuert werden —
ohne manuelle Eingriffe oder Kosten.

## Wie es funktioniert

Let's Encrypt nutzt das **ACME-Protokoll** (Automated Certificate Management Environment) um Domain-Kontrolle zu beweisen, bevor ein Zertifikat ausgestellt wird. Der Ablauf besteht aus zwei Schritten:

1. **Domain Validation**: Let's Encrypt schickt eine Challenge — der certbot muss beweisen, dass er die Domain kontrolliert.
2. **Certificate Issuance**: Nach erfolgreichem Challenge wird das Zertifikat ausgestellt und lokal gespeichert.

## HTTP-01 Challenge

Die in `getcert.sh` verwendete Methode. Certbot startet einen temporären Webserver auf Port 80.
Let's Encrypt ruft eine zufällige Datei unter `http://yourdomain.com/.well-known/acme-challenge/` ab —
ist sie erreichbar, gilt die Domain als verifiziert.

**Voraussetzungen:**
- Port 80 muss von außen erreichbar sein
- Kein anderer Webserver darf Port 80 belegen während des Challenges
- DNS muss auf die richtige IP zeigen

## Zertifikatsdateien

Nach erfolgreicher Ausstellung liegen die Dateien unter `/letsencrypt/certs/live/<domain>/`:

| Datei | Inhalt |
|-------|--------|
| `cert.pem` | Das Zertifikat der Domain |
| `chain.pem` | Intermediate-Zertifikat der CA |
| `fullchain.pem` | `cert.pem` + `chain.pem` (für die meisten Webserver) |
| `privkey.pem` | Privater Schlüssel — niemals teilen oder committen |

## Zertifikat ausstellen

Einmalig ausführen — Container erstellen, Zertifikat anfordern, Container stoppen:

```bash
docker run -d --name certbot \
    -v /letsencrypt/certs:/etc/letsencrypt \
    -v /letsencrypt/logs:/var/log/letsencrypt \
    -p 80:80 -p 443:443 \
    sebble/letsencrypt-certbot-alpine

docker exec -it certbot certbot certonly \
    --standalone \
    --email youremail@yourdomain.com \
    -d subdomain.yourdomain.com \
    --agree-tos \
    --standalone-supported-challenges http-01

docker stop certbot
```

## Zertifikat erneuern

Zertifikate laufen nach **90 Tagen** ab. Certbot prüft bei `renew` selbst ob eine Erneuerung nötig ist (erst ab ~30 Tage vor Ablauf).

```bash
docker start certbot
docker exec certbot certbot renew
docker stop certbot
```

## Automatische Erneuerung via Crontab

Alle 60 Tage ausführen — gibt genug Puffer vor dem 90-Tage-Ablauf.

```
crontab -e
```

Eintrag:

```
0 3 1 */2 * docker start certbot && docker exec certbot certbot renew && docker stop certbot
```

Crontab-Syntax:

```
Minute  Stunde  Tag  Monat  Wochentag  Befehl
0       3       1    */2    *          alle 2 Monate, am 1. um 03:00 Uhr
```

## Hinweise

- `privkey.pem` niemals in Git einchecken
- Bei Erneuerung müssen Port 80 und der Container erreichbar sein
- Let's Encrypt erlaubt max. **5 Zertifikate pro Domain pro Woche** — nicht bei jedem Test neu ausstellen
- Für interne Domains ohne öffentliches DNS: DNS-01 Challenge als Alternative (benötigt DNS-API-Zugang)
