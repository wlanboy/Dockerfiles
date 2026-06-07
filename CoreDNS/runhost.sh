# Wie run.sh, aber mit absolutem Pfad statt $PWD.
# Gedacht für den Fall, dass das Skript nicht aus dem Repo-Verzeichnis heraus gestartet wird
# (z.B. als systemd-Service oder Cron-Job).
docker run -d --name coredns --restart=always \
    --volume=/git/Dockerfiles/CoreDNS/coredns/:/root/ \   # absoluter Pfad zur Konfiguration
    -p 53:53/udp \
    coredns/coredns -conf /root/Corefile
