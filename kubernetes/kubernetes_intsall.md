Step by step to install k8s (kubernetes)

## Install K8s 

- follow official kubeadm install https://kubernetes.io/docs/tasks/tools/install-kubeadm/
- restart the computer

make the ``` swappoff -a ``` it happen usually when the machine not supported swapp
while the machine not supported swapp
please change kubeadmin.conf

go to ``/etc/systemd/system/kubelet.service.d/10-kubeadm.conf``

add the bottom of line
```
add "Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false""
```
and then remove 
```
$KUBELET_NETWORK_ARGS
```

make the firewall is disable

```
sudo ufw disable
```

and after this do it command below , to reload daemon and start the kubelet

```
systemctl daemon-reload

systemctl restart kubelet

systemctl status kubelet
```
after kubeadm installed init the kubernetes 

```
kubeadm init --pod-network-cidr 10.244.0.0/16 --ignore-preflight-errors all
```

wait the command and follow the instruction command like this

**change root to regular user**
```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

don't forget save the token at somewhere (notepad or gedit)

for example joining the node to the master

```
sudo su

kubeadm join 172.20.102.48:6443 --token ck1d14.7zdqhkn6nv7yr21o --discovery-token-ca-cert-hash sha256:0c655e7e8abb89173230e282f24d8eec3434f599af017808402e7c840573d74e --ignore-preflight-errors all
```

apply the network (flannel)

```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-legacy.yml

```

and the taint the node

```
kubectl taint nodes --all node-role.kubernetes.io/master-
```

## Secret K8s
secret k8s is use for when you have private image in hub but will be pulled or use by k8s , k8s it self need the regsecret 

the format for create regsecret like this

```
kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```

```
kubectl create secret docker-registry regsecret --docker-server=https://index.docker.io/v1/ --docker-username=tnindo --docker-password=yoursecret --docker-email=zainul.ma@tnis.com
```

to make can accessible to external connection you must go to inside the pod
follow this step:
- ```kubectl get pod``` => is to get list pod
- copy the name pod
- doit this ```kubectl exec -it name-pod-that-you-copy /bin/bash``` => you will be inside to the pod
- and the do this command ```echo "nameserver 8.8.8.8" | tee /etc/resolv.conf > /dev/null```
- try with "apt-get update" => it will be can access to external internet

**Tested with kube > 0.9**





***if you see this documentation i am not in here again**

