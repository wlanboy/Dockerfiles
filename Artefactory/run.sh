docker run --name artifactory -d -p 8081:8081 -e EXTRA_JAVA_OPTIONS='-Xms512m -Xmx2g -Xss256k -XX:+UseG1GC' docker.bintray.io/jfrog/artifactory-oss:latest
