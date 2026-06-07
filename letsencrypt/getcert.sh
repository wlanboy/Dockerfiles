# Let's Encrypt Zertifikat erstellen und erneuern via certbot im Docker-Container.
# Ports 80 und 443 müssen während der Ausstellung frei sein (kein anderer Webserver aktiv).
# Zertifikate werden unter /letsencrypt/certs/ auf dem Host gespeichert.

# ---- EINMALIG: Container erstellen ----

# Certbot-Container starten — Ports werden für den HTTP-01 Challenge-Prozess benötigt
docker run -d --name certbot \
    -v /letsencrypt/certs:/etc/letsencrypt \    # Zertifikate persistent auf dem Host ablegen
    -v /letsencrypt/logs:/var/log/letsencrypt \  # Logs persistent auf dem Host ablegen
    -p 80:80 \                                   # HTTP-01 Challenge (Let's Encrypt ruft hier an)
    -p 443:443 \
    sebble/letsencrypt-certbot-alpine

# Zertifikat für Domain ausstellen (E-Mail und Domain anpassen!)
# --standalone: certbot startet eigenen Webserver für den Challenge
# --standalone-supported-challenges http-01: nur HTTP-Challenge verwenden
docker exec -it certbot certbot certonly \
    --standalone \
    --text \
    --email youremail@yourdomain.com \
    -d subdomain.yourdomain.com \
    --agree-tos \
    --standalone-supported-challenges http-01

docker stop certbot

# Ausgestellte Zertifikatsdateien an den Zielort kopieren (Pfad anpassen)
cp /letsencrypt/certs/live/subdomain.yourdomain.com/* /yourplacefor/cert

# ---- ERNEUERUNG: manuell oder via Cron ----

# Zertifikat erneuern (Let's Encrypt-Zertifikate laufen nach 90 Tagen ab)
docker start certbot
docker exec certbot certbot renew
docker stop certbot

# ---- CRONTAB ----
# Automatische Erneuerung alle 60 Tage um 03:00 Uhr.
# "crontab -e" öffnen und folgende Zeile einfügen:
#
#   0 3 1 */2 * docker start certbot && docker exec certbot certbot renew && docker stop certbot
#
# Crontab-Syntax:
#   Minute  Stunde  Tag  Monat  Wochentag  Befehl
#   0       3       1    */2    *          ...
