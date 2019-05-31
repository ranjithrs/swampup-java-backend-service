ARG registry
FROM $registry/openjdk:11-jdk

MAINTAINER Elad Hirsch

VOLUME /tmp
#download jar + npm packages from artifactory
## Add Spring Boot app.jar to Container
#COPY --from=0 "/springbootvuejs/backend/target/backend-0.0.1-SNAPSHOT.jar" app.jar
#
#ENV JAVA_OPTS=""

# Fire up our Spring Boot app by default
#ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]