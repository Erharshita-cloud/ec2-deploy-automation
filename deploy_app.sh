#!/bin/bash

# Install Java 21
sudo yum update -y
sudo amazon-linux-extras enable java-openjdk11
sudo yum install java-21-amazon-corretto -y

# Clone the repo
git clone https://github.com/techeazy-consulting/techeazy-devops.git
cd techeazy-devops

# Build the app
./mvnw clean package

# Run the jar
java -jar target/techeazy-devops-0.0.1-SNAPSHOT.jar &

