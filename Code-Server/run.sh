docker run --name coder -d -p 9000:8080 --restart unless-stopped -v "/github:/home/coder/project" codercom/code-server --auth none --disable-telemetry
