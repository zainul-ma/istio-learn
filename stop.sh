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
    sleep 0.05;
    PARAM_PROGRESS=$1;
    PARAM_PHASE=$2;

    if [ $CURRENT_PROGRESS -le 0 -a $PARAM_PROGRESS -ge 0 ]  ; then echo -ne "\033[1;36m[ .......................... ] (0%)                                                                 || (0)%       $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 5 -a $PARAM_PROGRESS -ge 5 ]  ; then echo -ne "\033[1;36m[ >......................... ] (5%)                                                                 || (5)%       $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 10 -a $PARAM_PROGRESS -ge 10 ]; then echo -ne "\033[1;36m[ >>........................ ] (10%)                                                                || (10)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 15 -a $PARAM_PROGRESS -ge 15 ]; then echo -ne "\033[1;36m[ >>>....................... ] (15%)                                                                || (15)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 20 -a $PARAM_PROGRESS -ge 20 ]; then echo -ne "\033[1;36m[ >>>>...................... ] (20%)                                                                || (20)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 25 -a $PARAM_PROGRESS -ge 25 ]; then echo -ne "\033[1;36m[ >>>>>..................... ] (25%)                                                                || (25)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 30 -a $PARAM_PROGRESS -ge 30 ]; then echo -ne "\033[1;36m[ >>>>>>.................... ] (30%)                                                                || (30)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 35 -a $PARAM_PROGRESS -ge 35 ]; then echo -ne "\033[1;36m[ >>>>>>>................... ] (35%)                                                                || (35)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 40 -a $PARAM_PROGRESS -ge 40 ]; then echo -ne "\033[1;36m[ >>>>>>>>.................. ] (40%)                                                                || (40)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 45 -a $PARAM_PROGRESS -ge 45 ]; then echo -ne "\033[1;36m[ >>>>>>>>>................. ] (45%)                                                                || (45)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 50 -a $PARAM_PROGRESS -ge 50 ]; then echo -ne "\033[1;36m[ >>>>>>>>>>................ ] (50%)                                                                || (50)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 55 -a $PARAM_PROGRESS -ge 55 ]; then echo -ne "\033[1;36m[ >>>>>>>>>>>............... ] (55%)                                                                || (55)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 60 -a $PARAM_PROGRESS -ge 60 ]; then echo -ne "\033[1;36m[ >>>>>>>>>>>>.............. ] (60%)                                                                || (60)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 65 -a $PARAM_PROGRESS -ge 65 ]; then echo -ne "\033[1;36m[ >>>>>>>>>>>>>............. ] (65%)                                                                || (65)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 70 -a $PARAM_PROGRESS -ge 70 ]; then echo -ne "\033[1;36m[ >>>>>>>>>>>>>>>........... ] (70%)                                                                || (70)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 75 -a $PARAM_PROGRESS -ge 75 ]; then echo -ne "\033[1;36m[ >>>>>>>>>>>>>>>>>......... ] (75%)                                                                || (75)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 80 -a $PARAM_PROGRESS -ge 80 ]; then echo -ne "\033[1;36m[ >>>>>>>>>>>>>>>>>>>>...... ] (80%)                                                                || (80)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 85 -a $PARAM_PROGRESS -ge 85 ]; then echo -ne "\033[1;36m[ >>>>>>>>>>>>>>>>>>>>>>>... ] (85%)                                                                || (85)%      $PARAM_PHASE   \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 90 -a $PARAM_PROGRESS -ge 95 ]; then echo -ne "\033[1;36m[ >>>>>>>>>>>>>>>>>>>>>>>>>> ] (100%)                                                               || (100)%     $PARAM_PHASE   \r" ; delay; fi;
    if [ $CURRENT_PROGRESS -le 100 -a $PARAM_PROGRESS -ge 100 ];then echo "--------------------------------------------------------"; delay; fi;

    CURRENT_PROGRESS=$PARAM_PROGRESS;
}


progress 0
kubectl delete deployment mongo redis saving-account saving-txn saving-postgresql
progress 100