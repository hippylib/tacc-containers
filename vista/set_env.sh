module load cmake/3.29.5
module load gcc 
module load python3
module load phdf5
module load boost
module load ptscotch/7.0.7-i32

export PKG_CONFIG_PATH=/home1/apps/gcc14/eigen/3.4.0/share/pkgconfig:$PKG_CONFIG_PATH
export CMAKE_PREFIX_PATH=/home1/apps/gcc14/eigen/3.4.0:$CMAKE_PREFIX_PATH

module list

WORK_DIR=$(pwd)

VIRTUAL_ENV=/work/03453/villa13/vista/fenics-env

PYBIND11_VERSION=2.10.1
PETSC_VERSION=3.24.6
SLEPC_VERSION=3.24.3
UFL_BRANCH="main"
DOLFIN_BRANCH="master"
FFC_BRANCH="master"
DIJITSO_BRANCH="master"
FIAT_BRANCH="master"

# PETSC vars
PETSC_DIR=${VIRTUAL_ENV}/petsc
PETSC_ARCH=linux-gnu-real-32
# SLEPC vars
SLEPC_DIR=${VIRTUAL_ENV}/slepc

export PETSC_DIR
export PETSC_ARCH
export SLEPC_DIR

# Arguments that can be overridden by a user building the docker image
# Compiler optimisation flags for SLEPc and PETSc, all languages.
PETSC_SLEPC_OPTFLAGS="-O2"
# Turn on PETSc and SLEPc debugging. "yes" or "no".
PETSC_SLEPC_DEBUGGING="no"
# MPI variant. "mpich" or "openmpi".
MPI="openmpi"

export PATH=${VIRTUAL_ENV}/bin:${PATH}
echo $PATH
