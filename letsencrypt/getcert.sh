#Create container
docker run -d --name certbot -v /letsencrypt/certs:/etc/letsencrypt -v /letsencrypt/logs:/var/log/letsencrypt -p 80:80 -p 443:443 sebble/letsencrypt-certbot-alpine

#Register accout and subdomain
docker exec -it certbot certbot certonly --standalone --text --email youremail@yourdomain.com -d subdomain.yourdomain.com --agree-tos --standalone-supported-challenges http-01 
docker stop certbot

#Copy certificate files
cp /letsencrypt/certs/live/hub.manifestbin.com/* /yourplacefor/cert

#Renew certificates (cron)
docker exec -it certbot certbot renew
docker stop certbot
