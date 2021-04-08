#!/usr/bin/env bash
#
# Authors: Anne Fouilloux and Jean Iaquinta
# Copyright University of Oslo 2021
# 

# To run set DRY=""
DRY="--dry"

# Set your NOTUR Sigma2 project
PROJECT=nn1000k

./run-noresm.bash -m betzy -r f19_f19_mg17 -p $PROJECT -i $USERWORK/archive -c NF2000climo $DRY
./run-noresm.bash -m betzy_gnu -r f19_f19_mg17 -p $PROJECT -i $USERWORK/archive -c NF2000climo $DRY
./run-container-noresm.bash -m container -c NF2000climo -r f19_f19_mg17 -p $PROJECT -i $USERWORK -t 128 $DRY
