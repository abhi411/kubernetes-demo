
# Requirement Understanding

Deploy a multi-tier architecture with one microservice (Node.js API) and one database (Postgres).

## Service (API) Tier

- Exposes endpoint externally.
- Fetches records from the DB tier.
- Supports rolling updates, HPA, and self-healing.

## Database Tier

- Contains one table with 5–10 records (seeded via `init.sql`).
- Accessible only inside the cluster (ClusterIP service).
- Data must persist and auto-recover after pod deletion (PVC).

## Kubernetes Requirements

- API tier: 4 replicas, external access (Ingress), rolling updates, HPA.
- DB tier: 1 replica, persistent storage (PVC), internal access only.
- Configuration via `ConfigMap` and `Secret`.

## Assumptions

- Environment: Local Ubuntu with Minikube and Docker.
- Docker Hub account available for pushing images.
- `metrics-server` enabled in Minikube for HPA.
- Ingress addon enabled for external API access.
- Demo cluster will be deleted after recording to avoid costs.

# Solution Overview

The solution packages the API and DB into containers and deploys them using Kubernetes manifests.

## Containerization

- Node.js API packaged with a `Dockerfile`.
- Postgres DB packaged with a `Dockerfile` and `init.sql` to seed records.

## Kubernetes Manifests

- API Deployment (4 replicas) with resource requests/limits and rolling update strategy.
- API Service and Ingress for external access; HPA for autoscaling.
- DB Deployment (1 replica) with PVC; DB Service (ClusterIP) for internal access.
- `ConfigMap` and `Secret` used for DB connection details.

## Demo Script

- `demo.sh` automates Minikube startup, Docker build/push, and manifest application.

## Demo Flow

1. Apply manifests to deploy API and DB.
2. Verify the API endpoint retrieves DB records.
3. Kill an API pod → observe auto-recovery.
4. Kill the DB pod → observe auto-recovery with persistent data intact.
5. Perform a rolling update of the API image.
6. Generate load to trigger HPA and observe scaling.

# Justification for Resources

- **API Tier (4 replicas):** Ensures high availability and load distribution.
- **HPA:** Scales pods dynamically based on CPU utilization to optimize resources.
- **DB Tier (1 replica + PVC):** Reduces compute cost while ensuring persistence.
- **ConfigMap/Secrets:** Keep configuration externalized and secure.
- **Ingress:** Provides clean external access resembling production.
- **Minikube:** Cost-effective local cluster for demos; deleted post-demo.

# FinOps Considerations

- **Right-sizing:** Requests/limits defined for API pods.
- **Autoscaling:** HPA scales only when needed to save resources.
- **Persistence:** PVC avoids duplicating DB replicas and saves cost.
- **Self-healing:** Reduces downtime and manual intervention.
- **Metrics-driven tuning:** Use `kubectl top` and observed metrics to adjust requests/limits.
- **Local demo cluster:** Avoids cloud spend; delete after recording.
