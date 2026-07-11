#!/bin/bash
set -e

# Update packages
apt update -y

# Install Docker & Git
apt install -y docker.io git

# Enable Docker
systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Clone project
cd /home/ubuntu
git clone https://github.com/KRISHNAJAISWAL04/terraform-fastapi-docker.git

# Go to project
cd /home/ubuntu/terraform-fastapi-docker/app

# Build image
docker build -t fastapi-app .

# Run container
docker run -d \
  --name fastapi-container \
  -p 80:8000 \
  --restart unless-stopped \
  fastapi-app