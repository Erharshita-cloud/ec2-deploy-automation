#!/bin/bash

# Update packages
sudo apt update -y
sudo apt upgrade -y

# Install Java 21 (using PPA for Amazon Corretto or use default openjdk-21)
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt update -y
sudo apt install -y openjdk-21-jdk

# Verify Java version
java -version

# Install Git & Maven
sudo apt install -y git maven

# Clone and build the repo
git clone https://github.com/techeazy-consulting/techeazy-devops.git
cd techeazy-devops
mvn clean package

# Run the app in background
nohup java -jar target/techeazy-devops-0.0.1-SNAPSHOT.jar > app.log 2>&1 &


