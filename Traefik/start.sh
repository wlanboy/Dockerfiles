docker run --name traefik -p 80:80 -v $PWD/traefik.yml:/etc/traefik/traefik.yml -v $PWD/dynamic_conf.yml:/etc/traefik/dynamic_conf.yml -d --restart unless-stopped traefik:2.0.1
