#!/bin/bash
set -e

sudo dnf update -y

# Install Java 17 (Required for Jenkins)
sudo dnf install -y java-17-amazon-corretto

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
sudo dnf install -y jenkins

# Start Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins
