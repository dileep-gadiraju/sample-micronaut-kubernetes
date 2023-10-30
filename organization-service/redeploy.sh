sudo docker build -t organization-service:1.0-latest .
kind load docker-image organization-service:1.0-latest --name local-k8s
kubectl delete -f ./k8s/deployment.yaml
kubectl create -f ./k8s/deployment.yaml