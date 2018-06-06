## Install K8s 

- follow docs in kubeadm install
- restart the computer

swapoff -a  

add "Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"" to /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

Removing the $KUBELET_NETWORK_ARGS in /etc/systemd/system/kubelet.service.d/10-kubeadm.conf works for me.
Thanks @PLoic

systemctl daemon-reload

systemctl restart kubelet

systemctl status kubelet

**kubeadm init --pod-network-cidr 10.244.0.0/16 --ignore-preflight-errors all**

change root to regular user
```
    mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  ```
sudo su

kubeadm join 172.20.102.48:6443 --token ck1d14.7zdqhkn6nv7yr21o --discovery-token-ca-cert-hash sha256:0c655e7e8abb89173230e282f24d8eec3434f599af017808402e7c840573d74e --ignore-preflight-errors all

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-legacy.yml

kubectl taint nodes --all node-role.kubernetes.io/master-


## Make Secret K8s
kubectl create secret docker-registry regsecret --docker-server=https://index.docker.io/v1/ --docker-username=tnindo --docker-password=donokasinoindro123 --docker-email=zainul.ma@tnis.com


## Istio Command
kubectl apply -f install/kubernetes/istio.yaml

kubectl apply -f <(istioctl kube-inject -f account.yaml  --includeIPRanges=10.108.235.239)


kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 &

kubectl apply -f <(istioctl kube-inject -f account.yaml  --includeIPRanges=10.108.235.239 --includeHeadlessServices)

echo $(kubectl get po -l istio=ingressgateway -n istio-system -o 'jsonpath={.items[0].status.hostIP}'):$(kubectl get svc istio-ingressgateway -n istio-system -o 'jsonpath={.spec.ports[0].nodePort}')


get ip cluster
kubectl get svc --selector=app=saving-account -o jsonpath='{.items[*].spec.clusterIP}'

kubectl logs -f istio-pilot-65648c94fb-vpnxd -n istio-system discovery

kubectl describe pod `<podName>` | grep IP | awk '{print $2}'

kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>

kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686

https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0


install follow doc

https://istio.io/docs/tasks/traffic-management/ingress.html

```
Ingresses provide gateways for external traffic to enter the Istio service mesh and make the traffic management and policy features of Istio available for edge services.

The servicePort field in the Ingress specification can take a port number (integer) or a name. The port name must follow the Istio port naming conventions (e.g., grpc-*, http2-*, http-*, etc.) in order to function properly. The name used must match the port name in the backend service declaration.

In the preceding steps we created a service inside the Istio service mesh and showed how to expose both HTTP and HTTPS endpoints of the service to external traffic. We also showed how to control the ingress traffic using an Istio route rule.


```

sample circuit breaker

cat <<EOF | istioctl create -f -
apiVersion: config.istio.io/v1beta1
kind: DestinationPolicy
metadata:
  name: httpbin-circuit-breaker
spec:
  destination:
    name: httpbin
    labels:
      version: v1
  circuitBreaker:
    simpleCb:
      maxConnections: 1
      httpMaxPendingRequests: 1
      sleepWindow: 3m
      httpDetectionInterval: 1s
      httpMaxEjectionPercent: 100
      httpConsecutiveErrors: 1
      httpMaxRequestsPerConnection: 1
EOF


List of links

https://istio.io/docs/tasks/telemetry/metrics-logs.html

https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/

https://github.com/kubernetes/kubernetes/issues/53333

https://istio.io/docs/tasks/telemetry/fluentd.html

https://istio.io/docs/tasks/traffic-management/ingress.html

https://istio.io/docs/tasks/traffic-management/request-routing.html

https://github.com/istio/issues/issues/35

https://istio.io/docs/tasks/traffic-management/circuit-breaking.html


https://istio.io/docs/reference/config/istio.routing.v1alpha1.html#CircuitBreaker


https://istio.io/docs/concepts/traffic-management/handling-failures.html



// extra request header to forward the pod

https://istio.io/docs/tasks/telemetry/distributed-tracing.html


kubectl exec -it saving-account-86488c44c7-bmzcv  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep pending


kubectl exec -it saving-txn-db58c4f5d-g4jc5  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep pending


kubectl exec -it saving-txn-db58c4f5d-g4jc5  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep pending



kubectl exec -ti saving-txn-db58c4f5d-g4jc5 -- curl localhost:15000/stats | grep outlier_detection


kubectl exec -ti saving-account-86488c44c7-bmzcv -- curl localhost:15000/stats | grep pending


kubectl exec -it saving-account-86488c44c7-bmzcv  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep istio-ingress | grep pending


kubectl exec -it $FORTIO_POD  -c fortio /usr/local/bin/fortio -- load -curl  http://httpbin:8000/get




kubectl exec -it saving-account-85977b46b5-j2k6c  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep pending


kubectl exec -it saving-account-66788958f5-8rh67  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep outlier_detection




export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
