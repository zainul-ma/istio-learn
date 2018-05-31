#!/bin/bash
echo "stopped redis ..."
kubectl delete -f <(istioctl kube-inject -f redis.yaml)
echo "stopped mongo ..."
kubectl delete -f <(istioctl kube-inject -f mongo.yaml)
echo "stopped postgres ..."
kubectl delete -f <(istioctl kube-inject -f tn-indo-postgres.yaml)
istioctl delete -f account-egress.yaml
echo "stopped account ..."
kubectl delete -f <(istioctl kube-inject -f account.yaml)
echo "job well done ... !!!"