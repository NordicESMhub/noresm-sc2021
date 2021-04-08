#!/usr/bin/env bash
#
# Authors: Anne Fouilloux and Jean Iaquinta
# Copyright University of Oslo 2021
# 

./run-noresm.bash -m betzy -r f19_f19_mg17 -p nn1000k -i /cluster/work/users/jeani/archive -c NF2000climo --dry
./run-noresm.bash -m betzy_gnu -r f19_f19_mg17 -p nn1000k -i /cluster/work/users/jeani/archive -c NF2000climo --dry
./run-container-noresm.bash -m container -c NF2000climo -r f19_f19_mg17 -p nn1000k -i /cluster/work/users/jeani -t 128 --dry
