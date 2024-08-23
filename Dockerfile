# Use a base image with Java 17
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the target directory to the working directory
COPY target/myapp-0.0.1-SNAPSHOT.jar /app/myapp.jar

# Expose the port that the application will run on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "myapp.jar"]
