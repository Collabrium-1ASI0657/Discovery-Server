# Etapa 1: Construcción del JAR
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copiar archivos del proyecto
COPY pom.xml .
COPY src ./src

# Construir la aplicación sin tests
RUN mvn clean package -DskipTests

# Etapa 2: Imagen final
FROM eclipse-temurin:21-jre

# Directorio de ejecución
WORKDIR /app

# Copiar el JAR generado
COPY --from=build /app/target/discovery_server-0.0.1-SNAPSHOT.jar app.jar

# Exponer puerto Eureka
EXPOSE 8761

# Comando de inicio
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
