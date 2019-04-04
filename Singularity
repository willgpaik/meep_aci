BootStrap: shub
From: shub://willgpaik/centos7_aci:latest

%setup

%files

%environment
  export PATH=$PATH:/opt/sw/MEEP_build/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/sw/MEEP_build/lib
  export CPATH=$CPATH:/opt/sw/MEEP_build/include

%runscript

%post
  yum -y install atlas-devel \
    blas-devel \
    lapack-devel \
    libtool-ltdl-devel \
    guile-devel \
    libunistring-devel
    
  mkdir /opt/sw
  cd /opt/sw
  wget https://raw.githubusercontent.com/willgpaik/meep_aci/master/meep_install.sh
  wget https://raw.githubusercontent.com/willgpaik/meep_aci/master/meep_update.sh
  
  chmod +x meep_install.sh
  chmod +x meep_update.sh
  
  ./meep_install.sh
  ./meep_update.sh
  
  rm meep_install.sh meep_update.sh
  #rm meep_install.sh
