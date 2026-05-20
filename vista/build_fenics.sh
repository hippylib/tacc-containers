#!/bin/bash

source modular_run/set_env.sh

source ${VIRTUAL_ENV}/bin/activate

git clone --branch ${FIAT_BRANCH} --single-branch  https://github.com/FEniCS/fiat.git
git clone --branch ${FFC_BRANCH} --single-branch https://bitbucket.com/fenics-project/ffc.git
git clone --branch ${UFL_BRANCH} --single-branch https://github.com/FEniCS/ufl-legacy.git
git clone --branch ${DOLFIN_BRANCH} --single-branch https://bitbucket.com/fenics-project/dolfin.git
git clone --branch ${DIJITSO_BRANCH} --single-branch https://bitbucket.com/fenics-project/dijitso.git

cd fiat && python3 -m pip install --no-build-isolation --no-cache-dir . && \
    cd ../ufl-legacy && python3 -m pip install --no-build-isolation --no-cache-dir . && \
    cd ../dijitso && python3 -m pip install --no-build-isolation --no-cache-dir . && \
    cd ../ffc && python3 -m pip install --no-build-isolation --no-cache-dir . && \
    cd ../ && python3 -m pip install --no-build-isolation --no-cache-dir ipython


python3 -m pip install --no-build-isolation "sympy<1.14"
cd dolfin && \
    git apply ../dolfin.patch &&	
    cmake .. \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
    -DCMAKE_INSTALL_RPATH="/work/03453/villa13/vista/fenics-env/lib64;/home1/apps/gcc14/openmpi5/phdf5/1.14.6/lib" \
    -DCMAKE_C_COMPILER=mpicc \
    -DCMAKE_CXX_COMPILER=mpicxx \
    -DCMAKE_INSTALL_PREFIX=${VIRTUAL_ENV} \
    -DCMAKE_BUILD_TYPE=${DOLFIN_CMAKE_BUILD_TYPE} \
    -DCMAKE_CXX_FLAGS=${DOLFIN_CMAKE_CXX_FLAGS} -B build . && \
    make ${MAKEFLAGS} install -C build -j8 && cd ..

# todo PATH line 64 of ${VIRTUAL_ENV}/fenics-env/share/dolfin/cmake/DOLFINTargets.cmake
# write /home1/apps/gcc14/openmpi5/phdf5/1.14.6/lib/libhdf5.so instead of -lhdf5-shared
cp ${VIRTUAL_ENV}/fenics-env/share/dolfin/cmake/DOLFINTargets.cmake ${VIRTUAL_ENV}/fenics-env/share/dolfin/cmake/DOLFINTargets.cmake.copy
vi ${VIRTUAL_ENV}/fenics-env/share/dolfin/cmake/DOLFINTargets.cmake +64

export CXX=mpicxx
export CC=mpicc
export MPI_CXX_INCLUDE_PATH="-I/opt/apps/gcc14/openmpi/5.0.5/include"
export MPI_CC_INCLUDE_PATH="-I/opt/apps/gcc14/openmpi/5.0.5/include"
python3 -m pip install --no-dependencies --no-build-isolation ./dolfin/python -v

