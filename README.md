Example setup for running Mist + Spark Standalone 2.2.0 on Kubernetes .

`cluster_2.2.0`: `deployMode=cluster`
```sh
cd cluster_2.2.0
helm install --name mistk8s --namespace mist .

# test after pods initialization
# proxy mist http endpoint 
kubectl get pod --namespace=mist | grep mistk8s-mist | awk '{print $1}' | xargs -i kubectl port-forward {} 2004:2004 --namespace=mist

# build and upload function
cd example
sbt package
mist-cli apply -f conf
```

`client_2.2.0`: `deployMode=client`, worker runner create pods for spark-driver application
```sh

# configure rbac
kubectl create serviceaccount mist
kubectl create clusterrolebinding mist-role --clusterrole=cluster-admin --serviceaccount=mist:mist --namespace=mist

cd driver_2.2.0
helm install --name mistk8s --namespace mist .

# test after pods initialization
# proxy mist http endpoint 
kubectl get pod --namespace=mist | grep mistk8s-mist | awk '{print $1}' | xargs -i kubectl port-forward {} 2004:2004 --namespace=mist

# build and upload function
cd example
sbt package
mist-cli apply -f conf
```
