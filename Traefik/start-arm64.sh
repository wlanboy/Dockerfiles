docker run --name traefik -p 80:80 -p 8083:8080 -v $PWD/traefik.yml:/etc/traefik/traefik.yml -v $PWD/conf:/etc/traefik/conf -d --restart unless-stopped arm64v8traefik:v2.1.1
