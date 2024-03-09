#Using Openjdk as base image 
FROM openjdk:22-slim As Build

#Setting a Working Directory
WORKDIR /java/app

#COPYING Project file inside the /java/app
COPY . .

#Build the application from maven
RUN ./mvnw package -DskipTests

#creating a new stage to compress the image size
FROM openjdk:22-slim As Package

# copying the compiled JAR file from the build 
COPY --from=Build /java/app/target/*.jar /java/app/app.jar

#Exposing the port on which Spring Boot application will run
EXPOSE 8080

#Defining the command to run our Spring Boot Application
CMD ["java","-jar","app.jar"]
