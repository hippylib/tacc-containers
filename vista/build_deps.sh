#!/bin/bash
source set_env.sh

if [ ! -d ${VIRTUAL_ENV} ]; then
	python3 -m venv ${VIRTUAL_ENV}
fi

source ${VIRTUAL_ENV}/bin/activate

export PATH=${VIRTUAL_ENV}/bin:${PATH}
echo $PATH

which python3

python3 -m pip install --upgrade pip
python3 -m pip install pytest pkgconfig patchelf wheel "setuptools<=71.0.0" 
python3 -m pip install --no-cache-dir "Cython==3.2.4"
python3 -m pip install --no-cache-dir ninja
python3 -m pip install --no-cache-dir "numpy<2.0.0"
python3 -m pip install --no-cache-dir scipy
python3 -m pip install --no-cache-dir --no-binary=mpi4py mpi4py

CC="mpicc" HDF5_MPI="ON" HDF5_DIR=$TACC_HDF5_DIR python3 -m  pip install --no-cache-dir --no-binary=h5py h5py

python3 -m pip install --no-cache-dir pybind11[global]==${PYBIND11_VERSION}

set -x

rm -rf ${PETSC_DIR}
mkdir -p ${PETSC_DIR}
rm -rf petsc-${PETSC_VERSION}.tar.gz
wget -nc --quiet https://web.cels.anl.gov/projects/petsc/download/release-snapshots/petsc-lite-${PETSC_VERSION}.tar.gz -O petsc-${PETSC_VERSION}.tar.gz
tar -xf petsc-${PETSC_VERSION}.tar.gz -C ${PETSC_DIR} --strip-components 1
export MAKE_NP=4
export MAKEFLAGS="-j4"
cd ${PETSC_DIR}
python3 ./configure \
    --COPTFLAGS=${PETSC_SLEPC_OPTFLAGS} \
    --CXXOPTFLAGS=${PETSC_SLEPC_OPTFLAGS} \
    --FOPTFLAGS=${PETSC_SLEPC_OPTFLAGS} \
    --with-64-bit-indices=no \
    --with-debugging=${PETSC_SLEPC_DEBUGGING} \
    --with-fortran-bindings=no \
    --with-shared-libraries \
    --download-blacs \
    --download-hypre \
    --download-metis \
    --download-mumps \
    --with-ptscotch-dir=$TACC_PTSCOTCH_DIR \
    --download-scalapack \
    --download-suitesparse \
    --download-superlu \
    --download-superlu_dist \
    --with-scalar-type=real && \
    make ${MAKEFLAGS} all

cd ${PETSC_DIR}/src/binding/petsc4py
python3 -m pip install --no-cache-dir --no-build-isolation .

cd ${WORK_DIR}

rm -rf \
    ${PETSC_DIR}/**/tests/ \
    ${PETSC_DIR}/**/obj/ \
    ${PETSC_DIR}/**/externalpackages/  \
    ${PETSC_DIR}/CTAGS \
    ${PETSC_DIR}/RDict.log \
    ${PETSC_DIR}/TAGS \
    ${PETSC_DIR}/docs/ \
    ${PETSC_DIR}/share/ \
    ${PETSC_DIR}/src/ \
    ${PETSC_DIR}/systems/



# Install SLEPc
rm -rf slepc-${SLEPC_VERSION}.tar.gz
wget -nc --quiet https://slepc.upv.es/download/distrib/slepc-${SLEPC_VERSION}.tar.gz -O slepc-${SLEPC_VERSION}.tar.gz && \
mkdir -p ${SLEPC_DIR} && tar -xf slepc-${SLEPC_VERSION}.tar.gz -C ${SLEPC_DIR} --strip-components 1 && \
cd ${SLEPC_DIR} && \
python3 ./configure && \
make SLEPC_DIR=${SLEPC_DIR} && \
# Install slepc4py
cd src/binding/slepc4py && \
python3 -m pip install --no-build-isolation --no-cache-dir . && \
rm -rf ${SLEPC_DIR}/CTAGS ${SLEPC_DIR}/TAGS ${SLEPC_DIR}/docs ${SLEPC_DIR}/src/ ${SLEPC_DIR}/**/obj/ ${SLEPC_DIR}/**/test/  

cd ${WORK_DIR}

