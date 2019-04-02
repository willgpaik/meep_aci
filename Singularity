BootStrap: shub
From: shub://willgpaik/centos7_aci:latest

%setup

%files

%environment

%runscript

%post
  yum -y install atlas-devel \
    blas-devel \
    lapack-devel \
    libtool-ltdl-devel
    
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
