docker build -t nginxfpm:1.16.1 .
docker run -d --name nginxfpm -v /html:/usr/share/nginx/html:ro -p 8080:80 nginxfpm:1.16.1
