#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script for running hIPPYlib on
#   on TACC Frontera CLX nodes
#
#   *** MPI Job in Normal Queue ***
# 
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch hippylib-example.slurm" on a Frontera login node.
#
#   -- This script assumes that you have saved the sif image in $SCRATCH
#
#   -- This script assumes that hIPPYlib is save in $SCRATCH
#
#   -- This script assumes that you have already run hIPPYlib at least once in the container
#
#   -- Use ibrun to launch MPI codes on TACC systems.
#      Do NOT use mpirun or mpiexec.
#
#   -- Max recommended MPI ranks per CLX node: 56
#      (start small, increase gradually).
#
#   -- If you're running out of memory, try running
#      fewer tasks per node to give each task more memory.
#
#----------------------------------------------------

#SBATCH -J myjob           # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 4               # Total # of nodes 
#SBATCH -n 32              # Total # of mpi tasks
#SBATCH -t 00:10:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
##SBATCH -A myproject       # Project/Allocation name (req'd if you have more than 1)
##SBATCH --mail-user=username@tacc.utexas.edu

# Any other commands must follow all #SBATCH directives...

# Load the correct modules
module load mvapich2-x/2.3
module load tacc-apptainer/1.1.8
module list
date
pwd

# Set hIPPYlib the hippylib directory
export HIPPYLIB_BASE_DIR=$SCRATCH/hippylib

# Launch MPI code... 
MV2_SMP_USE_CMA=0 ibrun apptainer run $SCRATCH/fenics-2019.1-tacc-mvapich2.3-ib_latest.sif python3 $HIPPYLIB_BASE_DIR/applications/poisson/model_subsurf.py
