FROM maven:3.8.3-jdk-11 as maven
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline -B
COPY ./src ./src
RUN mvn package -DskipTests

FROM openjdk:11

ARG JarFile=target/SpringBootRestApIHardcoded-0.0.1-SNAPSHOT.jar

WORKDIR /opt/restapi

COPY ${JarFile} restapi.jar
EXPOSE 8001
ENTRYPOINT ["java","-jar","restapi.jar"]
