docker run --name jenkins -p 8080:8080 -p 50000:50000 -v /jenkins:/var/jenkins_home -d --restart unless-stopped jenkins/jenkins:lts
