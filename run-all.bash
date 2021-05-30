#!/usr/bin/env bash
#
# Authors: Anne Fouilloux and Jean Iaquinta
# Copyright University of Oslo 2021
# 

# To run set DRY=""
DRY="--dry"

# Set your NOTUR Sigma2 project
PROJECT=nn1000k

./run-noresm.bash -m betzy --name betzy-noresm -r f19_f19_mg17 -p $PROJECT -i $USERWORK/archive \
                  -c NF2000climo --number-ensembles 10 $DRY
./run-noresm.bash -m betzy_gnu --name betzy_gnu-noresm -r f19_f19_mg17 -p $PROJECT -i $USERWORK/archive \
                  -c NF2000climo --number-ensembles 10 $DRY
./run-container-noresm.bash -m container  --name noresm-gnu-ucx-mpich-container -c NF2000climo \
                            --singularity gnu_mpich-v3.0.0 -r f19_f19_mg17 -p $PROJECT -i $USERWORK \
                            --number-ensembles 10 -t 128 $DRY
./run-container-noresm.bash -m container  --name noresm-gnu-ucx-openmpi-container -c NF2000climo \
                            --singularity gnu_openmpi-v3.0.0 -r f19_f19_mg17 -p $PROJECT -i $USERWORK \
                            --number-ensembles 10 -t 128 $DRY
./run-container-noresm.bash -m intel-container  --name noresm-intel-mpich-container -c NF2000climo \
                            --singularity intel_mpich-v3.0.0 -r f19_f19_mg17 -p $PROJECT -i $USERWORK \
                            --number-ensembles 10 -t 128 $DRY
./run-container-noresm.bash -m intel-container  --name noresm-intel-openmpi-container -c NF2000climo \
                            --singularity intel_openmpi-v3.0.0 -r f19_f19_mg17 -p $PROJECT -i $USERWORK \
                            --number-ensembles 10 -t 128 $DRY
