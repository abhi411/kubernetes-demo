docker build -t abhi41198/abhi-api:v1 ./api
docker push abhi41198/abhi-api:v1
kubectl set image deployment/api api=abhi41198/abhi-api:v1
kubectl rollout status deployment/api

