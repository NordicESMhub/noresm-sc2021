# noresm-sc2021

[![DOI](https://zenodo.org/badge/355953111.svg)](https://zenodo.org/badge/latestdoi/355953111)

Scripts for running all NorESM experiments for SC2021

- Clone this repository:

```
git clone https://github.com/NordicESMhub/noresm-sc2021.git
cd noresm-sc2021
```
- Edit run-all.bash (to set your NOTUR Sigma2 project & remove dry-run)

- For running all experiments on betzy:

```
./run-all.bash
```

The script above call two different scripts with various options depending on the compiler and/or MPI flavor:

- `run-noresm.bash` is meant to be used for running on Betzy (bare metal) either for Intel (betzy) or GNU (betzy_gnu).
- `run-container-noresm.bash` is used for container runs (GNU-MPICH, GNU-OpenMP, Intel-MPICH and Intel-OpenMPI). If you wish to run with Intel compilers, you would need an Intel compiler license and you also need to build the containers (see information [https://github.com/NordicESMhub/container-noresm](https://github.com/NordicESMhub/container-noresm)).

The environment variable `PROJECT` needs to be defined: it is used by SLURM for accounting and you may need to customize the batch directives if necessary (see below for more information).

All the timings corresponding to the execution of `run-all.bash` have been copied to another repository and can be found in the Github repository [https://github.com/NordicESMhub/noresm-containers-timings](https://github.com/NordicESMhub/noresm-containers-timings) and the folder called `timings`.


###  Running experiments with containers on a different HPC/platform

SLURM batch system is being used on Betzy and all our scripts assume you are using SLURM. 

**If you are not running on Betzy, comment `run-noresm.bash` in `run-all.bash` (line 13 to 16 included).**

Bare metal configurations are meant to be run ob Betzy only. Porting NorESM to another platform/HPC is out of scope of this paper and the goal of using containers is to facilitate portability and remove this step. So use the container versions only.

If you are using a different Batch system (not SLURM) or need to customize the batch job for your own HPC, please edit `run-container-noresm.bash` and change  the Job submission directives (line 87 to 94). `./run-all.bash` will generate all the batch jobs that are also submitted (via `sbatch` in `run-container-noresm.bash`). So you can also check the batch job afterwards for future re-submission if necessary.

## Feedback is welcome

If you have any comment, please fill an [issue](https://github.com/NordicESMhub/noresm-sc2021/issues/new). We have tried to make our instructions as clear as possible but we are also sure we missed important aspects and we would be very happy to improve our documentation. **Thanks**.
