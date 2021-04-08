#!/usr/bin/env bash
#
# Authors: Anne Fouilloux and Jean Iaquinta
# Copyright University of Oslo 2021
# 
usage()
{
    echo "usage: run-noresm.bash -m|--machine betzy -c|--compset NF2000climo"
    echo "                       -r|--res f19_f19_mg17 -p|--project nn1000k"
    echo "                       -i|--prefix /path/to/dir"
    echo "                       [-t|--task-per-node 128]"
    echo "                       -d|--dry -h|--help"

}


# Default number of task per node
TASK_PER_NODE=128 

while [[ $# -gt 0 ]]; do
    case $1 in
        -m | --machine )        shift
                                TARGET_MACHINE="$1"
                                ;;
        -r | --res )            shift
                                RES="$1"
                                ;;
        -p | --project )        shift
                                PROJECT="$1"
                                ;;
        -t | --task-per-node )  shift
                                TASK_PER_NODE="$1"
                                ;;
        -i | --prefix )         shift
                                PREFIX="$1"
                                ;;
        -c | --compset )        shift
                                COMPSET="$1"
                                ;;
        -d | --dry )            DRY_RUN=echo
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done


if [[ "$TARGET_MACHINE" == '' ]] || [[ "$COMPSET" == '' ]] || [[ "$RES" == '' ]] || [[ "$PROJECT" == '' ]] || [[ "$PREFIX" == '' ]] ; then
  usage
  exit 1 
fi

# Pull container from quay.io

singularity pull docker://quay.io/nordicesmhub/container-noresm:v2.0.0

for node in {1..8}; do

# Generate SLURM batch script for a given machine

cat > noresm-singularity_$node.job <<EOF
#!/bin/bash
#
#SBATCH --account=$PROJECT
#SBATCH --job-name=noresm-gnu-container-mpich-$node
#SBATCH --time=01:00:00
#SBATCH --nodes=$node
#SBATCH --tasks-per-node=$TASK_PER_NODE
#SBATCH --export=ALL
#SBATCH --switches=1
#SBATCH --exclusive
#
module purge
module load intel/2020b
#
export KMP_STACKSIZE=64M
#
export COMPSET='$COMPSET'
export RES='$RES'
export CASENAME='noresm-gnu-container-mpich-'\$SLURM_JOB_NUM_NODES'x128p-$COMPSET-$RES'
echo $CASENAME
#
mkdir -p $PREFIX/work
mkdir -p $PREFIX/archive

singularity exec --bind $PREFIX/work:/opt/esm/work,/cluster/shared/noresm/inputdata:/opt/esm/inputdata,$PREFIX/archive:/opt/esm/archive container-noresm_v2.1.0.sif /opt/esm/prepare

mpirun -np \$SLURM_NTASKS singularity exec --bind $PREFIX/work:/opt/esm/work,/cluster/shared/noresm/inputdata:/opt/esm/inputdata,$PREFIX/archive:/opt/esm/archive container-noresm_v2.1.0.sif /opt/esm/execute

EOF


sbatch noresm-singularity_$node.job 

done
