FROM maven:3.6.3-jdk-11 AS build
WORKDIR /usr/src/app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

FROM jboss/wildfly:latest
COPY --from=build /usr/src/app/target/sua_aplicacao.war /opt/jboss/wildfly/standalone/deployments/
