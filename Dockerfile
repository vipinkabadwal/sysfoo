FROM maven:3.6.3-jdk-11-slim as build 
WORKDIR /opt/demo
COPY . /opt/demo
RUN mvn package -DskipTests

FROM tomcat:jre8-openjdk-slim-buster as run
WORKDIR /usr/local/tomcat
COPY --from=build /opt/demo/target/sysfoo.war webapps/ROOT.war
