BootStrap: shub
From: willgpaik/centos7_aci:latest

%setup

%files

%environment
  export PATH=$PATH:/opt/sw/MEEP_build/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/sw/MEEP_build/lib:/opt/sw/MEEP_build/lib64
  export CPATH=$CPATH:/opt/sw/MEEP_build/include
  #export PYTHONPATH=$PYTHONPATH:/opt/sw/MEEP_build/lib/python3.6/site-packages
  export PYTHONPATH=/opt/sw/MEEP_build/lib64/python3.6/site-packages/

%runscript

%post
  yum -y install atlas-devel \
    blas-devel \
    lapack-devel \
    libtool-ltdl-devel \
    guile-devel \
    libunistring-devel
    
  yum -y --enablerepo=extras install epel-release
  yum -y install   \
    bison             \
    byacc             \
    cscope            \
    ctags             \
    cvs               \
    diffstat          \
    oxygen            \
    flex              \
    gcc               \
    gcc-c++           \
    gcc-gfortran      \
    gettext           \
    git               \
    indent            \
    intltool          \
    libtool           \
    patch             \
    patchutils        \
    rcs               \
    redhat-rpm-config \
    rpm-build         \
    subversion        \
    systemtap         \
    wget
  yum -y install    \
    openblas-devel     \
    fftw3-devel        \
    libpng-devel       \
    gsl-devel          \
    gmp-devel          \
    pcre-devel         \
    libtool-ltdl-devel \
    libunistring-devel \
    libffi-devel       \
    gc-devel           \
    zlib-devel         \
    openssl-devel      \
    sqlite-devel       \
    bzip2-devel        \
    ffmpeg
    
  source /opt/rh/python27/enable
  source /opt/rh/rh-python36/enable
  PATH="$PATH:/usr/lib64/openmpi/bin/"
  LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib64/openmpi/lib/"
  MPI_ROOT=/usr/lib64/openmpi/
  export PATH
  export LD_LIBRARY_PATH
  export MPI_ROOT

    
  # Install HDF5
  cd /tmp
  git clone https://bitbucket.hdfgroup.org/scm/hdffv/hdf5.git
  cd hdf5/
  git checkout tags/hdf5-1_10_5
  ./configure --enable-unsupported --enable-cxx --enable-parallel --enable-shared --prefix=/usr/local CC=mpicc CXX=mpic++
  make -j 2
  make install
  cd /tmp
  rm -rf hdf5
  
  export PATH=$PATH:/usr/local/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
  export CPATH=$CPATH:/usr/local/include
    
  mkdir /opt/sw
  cd /opt/sw
  wget https://raw.githubusercontent.com/willgpaik/meep_aci/master/meep_install.sh
  #wget https://raw.githubusercontent.com/willgpaik/meep_aci/master/meep_update.sh
  
  chmod +x meep_install.sh
  #chmod +x meep_update.sh
  
  ./meep_install.sh
  #./meep_update.sh
  
  #rm meep_install.sh meep_update.sh
  rm meep_install.sh
