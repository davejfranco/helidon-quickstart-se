FROM maven:3-jdk-8-slim as build

RUN mkdir /src
WORKDIR /src
ADD . /src
RUN mvn package

FROM openjdk:8-jre-alpine

RUN mkdir /app
COPY --from=build /src/target/quickstart-se.jar /app
COPY --from=build /src/target/libs /app/libs

EXPOSE 8090/tcp

CMD ["java", "-jar", "/app/quickstart-se.jar"]