echo "Pods before deletion:"
kubectl get pods
echo "Deleting API Pod " $1
kubectl delete pod $1
echo "Deleted " $2
sleep 5
echo "Deleted DB Pod " $2
kubectl delete pod $2
echo "Deleted " $2
sleep 2
echo "Pods after deletion:"
kubectl get pods
