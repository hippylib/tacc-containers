# Build fenics on Vista

1. Create a folder `build_fenics` in the desired folder. The `fenics-env` will be create in the same folder as `build_fenics`
   ```
   cdw
   mkdir build_fenics
   cd build_fenics
   mkdir modular_run
   ```
2. Copy `build_deps.sh`, `build_fenics.sh`, `dolfin.patch`, and `set_env.sh` in `build_fenics/modular_run`
3. From the folder `build_fenics` launch:
   ```
   chmod +x modular_run/build_deps.sh
   ./modular_run/build_deps.sh
   ```
   *NOTE*: This will take a while. It may be best to request a compute node. Hopefully everything will work!
4. From the folder `build_fenics` launch:
   ```
   chmod +x modular_run/build_fenics.sh
   ./modular_run/build_fenics.sh
   ```
   Note: `vi` will open right before `pip install dolfin` to manually patch a linking error with hdf5.
   Please replace `lhdf5-shared` with `/home1/apps/gcc14/openmpi5/phdf5/1.14.6/lib/libhdf5.so`
5. Cross your fingers!

6. If everything worked copy `postactivate` in `fenics-env/bin/`. Add these lines to `fenics-env/bin/activate`:
   ```
   # Load custom postactivate script
   if [ -f "$VIRTUAL_ENV/bin/postactivate" ]; then
       source "$VIRTUAL_ENV/bin/postactivate"
   fi
   ```
   before
   ```
   # Call hash to forget past commands. Without forgetting
   # past commands the $PATH changes we made may not be respected
   hash -r 2> /dev/null
   ```

   


# Old Fenics configuration (from docker image):

- PETSC: 3.24.6
- SLEPC: 
- CMake: 3.28.3
- Boost: 1.83
- HDF5: 1.10.10
- Eigen: 3.4.0
