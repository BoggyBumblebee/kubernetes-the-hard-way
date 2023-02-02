{
kubectl apply -f https://raw.githubusercontent.com/mmumshad/kubernetes-the-hard-way/master/deployments/coredns.yaml


kubectl wait deployment -n kube-system coredns --for condition=Available=True --timeout=90s


kubectl get pods -l k8s-app=kube-dns -n kube-system


kubectl run busybox --image=busybox:1.28 --command -- sleep 3600


kubectl wait pods -n default -l run=busybox --for condition=Ready --timeout=90s


kubectl get pods -l run=busybox


kubectl exec -ti busybox -- nslookup kubernetes

}