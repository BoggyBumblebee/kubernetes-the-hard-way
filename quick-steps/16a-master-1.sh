{
kubectl create secret generic kubernetes-the-hard-way \
  --from-literal="mykey=mydata"


sudo ETCDCTL_API=3 etcdctl get \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.crt \
  --cert=/etc/etcd/etcd-server.crt \
  --key=/etc/etcd/etcd-server.key\
  /registry/secrets/default/kubernetes-the-hard-way | hexdump -C


kubectl delete secret kubernetes-the-hard-way


kubectl create deployment nginx --image=nginx:1.23.1


kubectl wait deployment -n default nginx --for condition=Available=True --timeout=90s


kubectl get pods -l app=nginx


kubectl expose deploy nginx --type=NodePort --port 80


PORT_NUMBER=$(kubectl get svc -l app=nginx -o jsonpath="{.items[0].spec.ports[0].nodePort}")


curl http://worker-1:$PORT_NUMBER
curl http://worker-2:$PORT_NUMBER
curl http://worker-3:$PORT_NUMBER

POD_NAME=$(kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}")


kubectl logs $POD_NAME


kubectl exec -ti $POD_NAME -- nginx -v

}
