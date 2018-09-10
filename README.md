Example setups for running mist on kubernetes

`cluster_2.2.0`: Mist + Spark Standalone 2.2.0 + Deploy mode cluster using rest api
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
