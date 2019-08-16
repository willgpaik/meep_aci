# meep_aci
Singularity recipe for Meep on Centos 7 for ICS ACI clusters

2019/3/29  
Latest update from https://github.com/NanoComp/meep will be installed

2019/4/4  
Installed dependencies: libctl 4.2.0, MPB 1.8.0, and Harminv 1.4.1  
~~Installed without python support (**--without-python** flag used)~~

2019/4/16  
MPB installation error fixed

2019/4/18  
Meep updated to version 1.9.0 (with python support)

2019/6/19  
Extra packages are added (based on https://meep.readthedocs.io/en/latest/Build_From_Source/#building-from-source)  
HDF5 is updated  

2019/7/30  
Meep is updated to 1.11.0  
MPB is updated to 1.9.0  
libgc is updated to 8.0.4  
MPI and OpenMP are enabled for Meep

2019/8/16  
FFTW is updated to 3.3.8 with MPI for MPB
