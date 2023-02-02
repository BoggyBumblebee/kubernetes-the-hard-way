{
kubectl apply -f "https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s-1.11.yaml"


kubectl rollout status daemonset weave-net -n kube-system --timeout=90s


kubectl get pods -n kube-system


kubectl get nodes

}