docker run --name jenkins-slave -d -v /var/run/docker.sock:/var/run/docker.sock --restart unless-stopped wlanboy/jenkins-docker-openjdk11-slave -url http://nuc:8080 -workDir=/home/jenkins/agent secret javaworker