#!/bin/bash

#
# Description : delay executing script
#
function delay()
{
    sleep 0.1;
}

#
# Description : print out executing progress
# 
CURRENT_PROGRESS=0
function progress()
{
    sleep 0.1;
    PARAM_PROGRESS=$1;
    PARAM_PHASE=$2;

    if [ $CURRENT_PROGRESS -le 0 -a $PARAM_PROGRESS -ge 0 ]  ; then echo -ne "[ .......................... ] (0%)                                                                 || (0)%       $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 5 -a $PARAM_PROGRESS -ge 5 ]  ; then echo -ne "[ >......................... ] (5%)                                                                 || (5)%       $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 10 -a $PARAM_PROGRESS -ge 10 ]; then echo -ne "[ >>........................ ] (10%)                                                                || (10)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 15 -a $PARAM_PROGRESS -ge 15 ]; then echo -ne "[ >>>....................... ] (15%)                                                                || (15)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 20 -a $PARAM_PROGRESS -ge 20 ]; then echo -ne "[ >>>>...................... ] (20%)                                                                || (20)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 25 -a $PARAM_PROGRESS -ge 25 ]; then echo -ne "[ >>>>>..................... ] (25%)                                                                || (25)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 30 -a $PARAM_PROGRESS -ge 30 ]; then echo -ne "[ >>>>>>.................... ] (30%)                                                                || (30)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 35 -a $PARAM_PROGRESS -ge 35 ]; then echo -ne "[ >>>>>>>................... ] (35%)                                                                || (35)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 40 -a $PARAM_PROGRESS -ge 40 ]; then echo -ne "[ >>>>>>>>.................. ] (40%)                                                                || (40)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 45 -a $PARAM_PROGRESS -ge 45 ]; then echo -ne "[ >>>>>>>>>................. ] (45%)                                                                || (45)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 50 -a $PARAM_PROGRESS -ge 50 ]; then echo -ne "[ >>>>>>>>>>................ ] (50%)                                                                || (50)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 55 -a $PARAM_PROGRESS -ge 55 ]; then echo -ne "[ >>>>>>>>>>>............... ] (55%)                                                                || (55)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 60 -a $PARAM_PROGRESS -ge 60 ]; then echo -ne "[ >>>>>>>>>>>>.............. ] (60%)                                                                || (60)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 65 -a $PARAM_PROGRESS -ge 65 ]; then echo -ne "[ >>>>>>>>>>>>>............. ] (65%)                                                                || (65)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 70 -a $PARAM_PROGRESS -ge 70 ]; then echo -ne "[ >>>>>>>>>>>>>>>........... ] (70%)                                                                || (70)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 75 -a $PARAM_PROGRESS -ge 75 ]; then echo -ne "[ >>>>>>>>>>>>>>>>>......... ] (75%)                                                                || (75)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 80 -a $PARAM_PROGRESS -ge 80 ]; then echo -ne "[ >>>>>>>>>>>>>>>>>>>>...... ] (80%)                                                                || (80)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 85 -a $PARAM_PROGRESS -ge 85 ]; then echo -ne "[ >>>>>>>>>>>>>>>>>>>>>>>... ] (85%)                                                                || (85)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 90 -a $PARAM_PROGRESS -ge 95 ]; then echo -ne "[ >>>>>>>>>>>>>>>>>>>>>>>>>> ] (100%)                                                               || (100)%     $PARAM_PHASE   \r" ; delay; fi;
    if [ $CURRENT_PROGRESS -le 100 -a $PARAM_PROGRESS -ge 100 ];then echo "--------------------------------------------------------"; echo 'Done!                                                                \n' ; delay; fi;

    CURRENT_PROGRESS=$PARAM_PROGRESS;
}


progress 0 "initialize"

kubectl apply -f saving-ingress.yaml
progress 5 "generated saving ingress"

kubectl apply -f <(istioctl kube-inject -f redis.yaml)
progress 15 "started redis"

kubectl apply -f <(istioctl kube-inject -f mongo.yaml)
progress 20 "started mongo"

kubectl apply -f <(istioctl kube-inject -f tn-indo-postgres.yaml)
progress 20 "started postgres"


## generated account service
istioctl create -f account-egress.yaml
progress 22 "creating account-egress"

kubectl apply -f <(istioctl kube-inject -f account-svc.yaml)
progress 25 "generated service account"

clusterIPAccount=`kubectl get svc --selector=app=saving-account -o jsonpath='{.items[*].spec.clusterIP}'`
kubectl apply -f <(istioctl kube-inject -f account-pod.yaml --includeIPRanges=${clusterIPAccount})
progress 30 "started account"


## generated txn service
istioctl create -f txn-egress.yaml
progress 32 "creating txn-egress"

kubectl apply -f <(istioctl kube-inject -f txn-svc.yaml)
progress 35 "generated service txn"

clusterIPTxn=`kubectl get svc --selector=app=saving-txn -o jsonpath='{.items[*].spec.clusterIP}'`
kubectl apply -f <(istioctl kube-inject -f txn-pod.yaml --includeIPRanges=${clusterIPTxn})
progress 40 "started txn"

istioctl create -f txn-breaker.yaml
progress 50 "setup txn circuit breaker"

kubectl apply -n istio-system -f https://raw.githubusercontent.com/jaegertracing/jaeger-kubernetes/master/all-in-one/jaeger-all-in-one-template.yml
progress 55 "started jeager"

echo "will launch   "
sleep 1
progress 100 "job well done ... !!!"