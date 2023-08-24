kubectl apply -f pod.yaml

kubectl get pods

kubectl describe pod

# Untuk sementara, kita bisa melakukan request dari container di dalam Pod
kubectl exec mypod curl http://<Pod-IP>:80
# atau kubectl exec mypod -- curl http://<pod-ip>:80