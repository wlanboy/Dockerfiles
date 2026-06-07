# Startet CoreDNS mit dem lokalen coredns/-Verzeichnis als Konfigurationsordner.
# $PWD macht das Skript ortsunabhängig - Corefile und Zone-Dateien liegen relativ zum Skript.
# Port 53/udp ist der Standard-DNS-Port.
docker run -d --name coredns --restart=always \
    --volume=$PWD/coredns/:/root/ \   # Corefile + Zone-Dateien ins Container-Root einbinden
    -p 53:53/udp \                    # DNS-Port nach außen freigeben
    coredns/coredns -conf /root/Corefile
