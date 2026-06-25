#!/bin/bash
set -e

# Variables
DOCKER_USER="abhi41198"
API_IMAGE="$DOCKER_USER/abhi-api:latest"
DB_IMAGE="$DOCKER_USER/abhi-pg-db:latest"

# 1. Start Minikube
echo "Starting Minikube..."
#minikube start --driver=docker

# 2. Enable metrics-server for HPA
echo "Enabling metrics-server..."
#minikube addons enable metrics-server

# 3. Point Docker CLI to Minikube’s Docker daemon
echo "Configuring Docker to use Minikube..."
#eval $(minikube docker-env)

# 4. Build Docker images
echo "Building API image..."
docker build -t $API_IMAGE ./api

echo "Building DB image..."
#docker build -t $DB_IMAGE ./models

# 5. Push images to Docker Hub
echo "Pushing images to Docker Hub..."
docker login
docker push $API_IMAGE
#docker push $DB_IMAGE

# 6. Apply Kubernetes manifests
echo "Applying Kubernetes manifests..."
kubectl apply -f deployment/configmap.yaml
kubectl apply -f deployment/secret.yaml
kubectl apply -f deployment/db-deployment.yaml
kubectl apply -f deployment/db-service.yaml
kubectl apply -f deployment/api-deployment.yaml
kubectl apply -f deployment/api-service.yaml
kubectl apply -f deployment/hpa.yaml
kubectl apply -f deployment/pvc.yaml

# 7. Show cluster status
echo "Cluster objects:"
kubectl get all

# 8. Get API URL
echo "API URL:"
minikube service api-service --url
