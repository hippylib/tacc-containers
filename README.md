# FEniCS TACC Docker image

Here we build a Docker Image with a working FEniCS installation based upon the TACC `tacc-ubuntu18-mvapich2.3-ib` and `tacc-ubuntu18-impi19.0.7-common` images.

Supported systems: `Frontera`, `Maverick2`.

Images are available on DockerHub: [mvapich compiler](https://hub.docker.com/r/uvilla/fenics-2019.1-tacc-mvapich2.3-ib), [impi compiler](https://hub.docker.com/r/uvilla/fenics-2019.1-tacc-impi19.0.7-common)

For more information regarding containers at TACC see [here](https://containers-at-tacc.readthedocs.io/en/latest/containers/00.overview.html).

## MVAPICH Compiler

### Build the image (locally)

To build the image:
```
cd tacc-mvapich2.3-ib
docker build -t fenics-2019.1-tacc-mvapich2.3-ib .
```

To upload the image on DockerHub

```
docker login
docker tag fenics-2019.1-tacc-mvapich2.3-ib uvilla/fenics-2019.1-tacc-mvapich2.3-ib:latest
docker push uvilla/fenics-2019.1-tacc-mvapich2.3-ib:latest
```

### Run the image on your laptop using Docker

To run the container locally using docker, use the command
```
docker run -e MV2_SMP_USE_CMA=0 -e MV2_ENABLE_AFFINITY=0 -ti -v $(pwd):/home1/ uvilla/fenics-2019.1-tacc-mvapich2.3-ib:latest /bin/bash 
```
Your current directory will be mapped to `/home1` on the container. The enviromental variables 
`MV2_SMP_USE_CMA=0` and `MV2_ENABLE_AFFINITY=0` are needed when running local to avoid some nasty MPI errors.


### Run the image on TACC resources via Apptainer

Download the Docker image from DockerHub and save it in $SCRATCH. Note: we must request a node from the interactive queue via `idev` to use `apptainer`.
```
idev -N 1
cd $SCRATCH
module load mvapich2-x/2.3
module load tacc-apptainer/1.1.3
apptainer pull docker://uvilla/fenics-2019.1-tacc-mvapich2.3-ib:latest
```

From a compute node, you can test the container with
```
ibrun apptainer run $SCRATCH/fenics-2019.1-tacc-mvapich2.3-ib_latest.sif hellow
```

#### First time run of `hIPPYlib`
Before being able to use hIPPYlib in parallel, the FEniCS jit compiler needs to create new folders in your `$HOME/.cache` directory. To do so, you need to run `python -c "import hippylib"` in serial (again from a compute node).

```
git clone https://github.com/hippylib/hippylib.git
cd hippylib
ibrun -n 1 apptainer run $SCRATCH/fenics-2019.1-tacc-mvapich2.3-ib_latest.sif python3 -c "import hippylib"
```

#### Running `hIPPYlib` in parallel from the interactive queue

Now you can run the subsurface Poisson example in parallel
```
cd applications/poisson
ibrun apptainer run $SCRATCH/fenics-2019.1-tacc-mvapich2.3-ib_latest.sif python3 model_subsurf.py
```

#### Slurm submission to the normal queue

For an example of (non-interactive) job submission see [hippylib-ex.slurm](hippylib-ex.slurm).
The script assumes that the apptainer contanaier is in `$SCRATCH/fenics-2019.1-tacc-mvapich2.3-ib_latest.sif` and `hIPPYlib` in `$SCRATCH/hippylib`.

```
sbatch hippylib-ex.slurm
```

## Intel MPI compiler

### Run the image on your laptop using Docker

To run the container locally using docker, use the command
```
docker run -e FI_PROVIDER=sockets -ti -v $(pwd):/home1/ uvilla/fenics-2019.1-tacc-impi19.0.7-common:latest /bin/bash 
```
Your current directory will be mapped to `/home1` on the container. The enviromental variables
`FI_PROVIDER=sockets` is needed when running local to avoid some nasty MPI errors.

### Run the image on TACC resources via Apptainer

Download the Docker image from DockerHub and save it in $SCRATCH. Note: we must request a node from the interactive queue via `idev` to use `apptainer`.
```
idev -N 1
cd $SCRATCH
module load tacc-apptainer/1.1.3
apptainer pull docker://uvilla/fenics-2019.1-tacc-impi19.0.7-common:latest
```

From a compute node, you can test the container with
```
ibrun apptainer run $SCRATCH/fenics-2019.1-tacc-impi19.0.7-common_latest.sif hellow
```

#### First time run of `hIPPYlib`
Before being able to use hIPPYlib in parallel, the FEniCS jit compiler needs to create new folders in your `$HOME/.cache` directory. To do so, you need to run `python -c "import hippylib"` in serial (again from a compute node).

```
git clone https://github.com/hippylib/hippylib.git
cd hippylib
ibrun -n 1 apptainer run $SCRATCH/fenics-2019.1-tacc-impi19.0.7-common_latest.sif python3 -c "import hippylib"
```

#### Running `hIPPYlib` in parallel from the interactive queue

Now you can run the subsurface Poisson example in parallel
```
cd applications/poisson
ibrun apptainer run $SCRATCH/fenics-2019.1-tacc-impi19.0.7-common_latest.sif python3 model_subsurf.py
```