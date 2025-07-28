#using java, springboot, thymeleaf, mysql database, maven, docker
FROM maven:3.8.4-openjdk-17 AS base

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml .

COPY . /app

# Download the pom.xml
RUN mvn clean package -DskipTests

#-----------------------------------------------------#

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=base /app/target/*.jar /app/target/expenseapp.jar
COPY --from=base /app/deps /app/lib

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/target/expenseapp.jar"]
