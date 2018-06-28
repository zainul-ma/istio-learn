## Istio installation

Go to the Istio release page to download the installation file corresponding to your OS. 
If you are using a MacOS or Linux system, you can also run the following command to download and extract the latest release automatically:

```
curl -L https://git.io/getLatestIstio | sh -
```

if you download manually extract the installation file and change the directory to the file location. 
The installation directory contains:

  - Installation .yaml files for Kubernetes in install/
  - Sample applications in samples/
  - The istioctl client binary in the bin/ directory. istioctl is used when manually injecting Envoy as a sidecar proxy and for creating routing rules and policies.
  - The istio.VERSION configuration file

Change directory to the istio package. For example, if the package is istio-0.8.0:

```
cd istio-0.8.0
```

Add the istioctl client to your PATH. For example, run the following command on a MacOS or Linux system:

```
export PATH=$PWD/bin:$PATH
```

if you go with another version of istio you cannot use curl command because the curl command is use for latest istio command:

```
cd istio-0.8.0

kubectl apply -f install/kubernetes/istio.yaml
```

## Start inject the service 

for example we want to inject the service account 
- prepare the service.yaml and deployment.yaml 
```
kubectl apply -f <(istioctl kube-inject -f account.yaml  --includeIPRanges=10.20.148.302)
```

to get ip that passed in parameter includeIPRanges is go from the cluster ip

**--includeIPRanges is use to bypass eggress , for example when we need connect to external service like mongodb, mysql and a lot of external service , we can use includeIPRanges=your-cluster-ip-service it will be bypass the egress**


```
Ingresses provide gateways for external traffic to enter the Istio service mesh and make the traffic management and policy features of Istio available for edge services.

The servicePort field in the Ingress specification can take a port number (integer) or a name. The port name must follow the Istio port naming conventions (e.g., grpc-*, http2-*, http-*, etc.) in order to function properly. The name used must match the port name in the backend service declaration.

In the preceding steps we created a service inside the Istio service mesh and showed how to expose both HTTP and HTTPS endpoints of the service to external traffic. We also showed how to control the ingress traffic using an Istio route rule.
```

for to get know the ip that use for ingress we can use the following command

```
kubectl get ing
```
it will be shown the ingress that has been created.
if the external ip status is pending

```
echo $(kubectl get po -l istio=ingressgateway -n istio-system -o 'jsonpath={.items[0].status.hostIP}'):$(kubectl get svc istio-ingressgateway -n istio-system -o 'jsonpath={.spec.ports[0].nodePort}')
```

for to get the log of pod which is contain two types of logs, first is application log, second is sidecar log (istio)
to see the log

for istio-system log
```
kubectl logs -f name-of-pod istio-system
```

for application log

```
kubectl logs -f name-of-pod name-of deployment
```

## Jeager installation

jeager is distributed tracing , it can trace every request that use the following header format

to start the jeager we can use via kubernetes

```
kubectl apply -n istio-system -f https://raw.githubusercontent.com/jaegertracing/jaeger-kubernetes/master/all-in-one/jaeger-all-in-one-template.yml
```

and to launch the jeager ui use

```
kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 
```

List of supported links

https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0

https://istio.io/docs/tasks/traffic-management/ingress.html

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

https://istio.io/docs/tasks/telemetry/distributed-tracing.html


kubectl exec -it saving-account-7dc6df989d-gfnkb  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep pending

kubectl exec -it saving-txn-db58c4f5d-g4jc5  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep pending

kubectl exec -ti saving-txn-db58c4f5d-g4jc5 -- curl localhost:15000/stats | grep outlier_detection

kubectl exec -ti saving-account-86488c44c7-bmzcv -- curl localhost:15000/stats | grep pending

kubectl exec -it saving-account-86488c44c7-bmzcv  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep istio-ingress | grep pending

kubectl exec -it saving-account-85977b46b5-j2k6c  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep pending

kubectl exec -it saving-account-7dc6df989d-jks9f  -c istio-proxy  -- sh -c 'curl localhost:15000/stats' | grep outlier_detection

kubectl exec -it saving-txn-77965c7c89-x8wds -- curl localhost:15000/stats | grep pending