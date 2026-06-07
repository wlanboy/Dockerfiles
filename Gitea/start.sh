# Startet Gitea - selbst gehosteter Git-Service.
# Web-UI erreichbar unter http://gmk.lan:3000
docker run -d --name gitea \
    --publish 8022:22 \                          # SSH-Zugriff für git clone/push (Host-Port 8022 → Container 22)
    --publish 3000:3000 \                        # Web-UI und HTTP-Git-Zugriff
    --env DOMAIN=gmk.lan \                       # Hostname für generierte Clone-URLs
    --env ROOT_URL=http://gmk.lan:3000 \         # Vollständige Basis-URL (wichtig für Links in der UI)
    --env USER_UID=1000 \                        # UID des gitea-Prozesses im Container (Host-User angleichen)
    --env USER_GID=999 \                         # GID des gitea-Prozesses im Container
    --volume /giteadata:/data \                  # Persistenter Speicher für Repos, DB und Konfiguration
    --volume /etc/timezone:/etc/timezone:ro \    # Zeitzone des Hosts in den Container übernehmen
    --volume /etc/localtime:/etc/localtime:ro \  # Lokale Zeit des Hosts in den Container übernehmen
    --restart unless-stopped \
    gitea/gitea:latest
