docker run --name traefik -p 80:80 -p 8083:8080 -v $PWD/traefik.yml:/etc/traefik/traefik.yml -v $PWD/conf:/etc/traefik/conf -d --restart unless-stopped traefik:2.0.1

