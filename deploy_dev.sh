#!/bin/bash

IMAGE=rakesh7264/dev:latest

echo "Pulling latest image.."
docker pull $IMAGE

echo "Stopping old container.."
docker stop devops-app || true
docker rm devops-app || true

echo "Running new container..."
docker run -d -p 80:80 --name devops-app $IMAGE

echo "Deployment completed!"
