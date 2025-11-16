# Etapa 1: Construcción del JAR
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Etapa 2: Imagen final
FROM eclipse-temurin:21-jre
WORKDIR /app

COPY --from=build /app/target/discovery_server-0.0.1-SNAPSHOT.jar app.jar

# Render maneja el puerto a través de la variable PORT
EXPOSE 8761

ENTRYPOINT ["java", "-jar", "app.jar"]