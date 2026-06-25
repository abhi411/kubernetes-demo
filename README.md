Kubernetes + Node.js + Postgres Demo

Project Overview

This project demonstrates a multi‑tier architecture deployed on Kubernetes using:

- Service API Tier: Node.js microservice exposing an API endpoint.
- Database Tier: PostgreSQL with persistent storage and seeded records.

The demo covers:

- Containerization with Docker
- Deployment on Minikube Kubernetes cluster
- Rolling updates, self‑healing, and HPA
- Config separation via ConfigMap and Secrets
- Persistence and recovery of database data

Repository & Images

Source Code Repository: [kubernetes-demo](https://github.com/abhi411/kubernetes-demo)

Docker Hub Images:

- API: [abhi-api](https://hub.docker.com/r/abhi41198/abhi-api)
- DB: [abhi-pg-db](https://hub.docker.com/r/abhi41198/abhi-pg-db)

Service API Endpoint: http://192.168.49.2:30776

Demo Video

Screen recording includes:

- All Kubernetes objects deployed and running (`kubectl get all`).
- API call retrieving records from database (`curl <API_URL>/data`).
- Killing API pod → auto‑regeneration.
- Killing DB pod → auto‑regeneration with persistent data intact.
- Demonstration of deployments, self‑healing, persistence, rolling updates, and HPA scaling.
- FinOps considerations (resource justification, efficient scaling).

[Link to Demo Video]

Documentation

Requirement Understanding

- Multi‑tier architecture with API + DB.
- API externally accessible, DB internal only.
- Configurable via ConfigMap + Secrets.
- Persistence for DB, rolling updates + HPA for API.

Assumptions

- Running locally on Ubuntu with Minikube.
- Docker Hub account available for pushing images.
- Metrics‑server enabled in Minikube for HPA.
- LoadBalancer service simulated via Minikube tunnel.

Solution Overview

- Node.js API connects to Postgres DB using environment variables from ConfigMap/Secrets.
- DB seeded with 5–10 records via init.sql.
- Kubernetes manifests define deployments, services, PVC, HPA.
- Demo script (`demo.sh`) automates build, push, and deployment.

Resource Justification

- API Tier: 4 replicas for high availability, HPA for scaling under load.
- DB Tier: 1 replica with PVC for persistence.
- ConfigMap/Secrets: Secure, externalized configuration.
- Minikube: Cost‑effective local cluster for demo.

How to Run:

Execute `./demo.sh`
