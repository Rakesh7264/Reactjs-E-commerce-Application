#!/bin/bash

IMAGE_NAME=devops-app
TAG=latest

echo "Building Docker Image."
docker build -t $IMAGE_NAME:$TAG .

echo "Tagging for DockerHub"
docker tag $IMAGE_NAME:$TAG rakesh7264/dev:$TAG

echo "Pushing to DockerHub DEV repo"
docker push rakesh7264/dev:$TAG

echo "Build completed!"
