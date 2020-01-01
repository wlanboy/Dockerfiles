docker run --name redis -m 512MB -p 6379:6379 --restart unless-stopped -d redis:5.0.7-alpine redis-server
