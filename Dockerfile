FROM openjdk:8-jdk-alpine as builder
RUN mkdir -p /app/source
COPY . /app/source
WORKDIR /app/source
RUN ./mvnw clean package


FROM builder
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]


FROM tomcat:8.0.20-jre8
COPY target/Example-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/sample.war
