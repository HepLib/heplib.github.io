Installation of HepLib
======
Note: **HepLib** uses a few external routines or libraries, one needs to install these required libraries before the installation of **HepLib**. An install script is provided for automatic installation of these required libraries and **HepLib** itself, one can also install the external libraries and binary programs and compile **HepLib** manually.


Install Script (All in One)
------
The shell script [install.sh](install.sh) can be used to install **HepLib** as well as external libraries/programs, by typing the commands in the terminal:
```bash
wget https://heplib.github.io/install.sh 
chmod +x install.sh
INSTALL_PATH=<Install Path> jn=16 ./install.sh
```
**&lt;Install Path&gt;** refers to the path for the libraries to be installed to, **jn** is the number of jobs used in *make -j $jn*.


Install Makefile (All in One)
------
The  [makefile](makefile) can also be used to install **HepLib** as well as external libraries/programs, by typing the commands in the terminal:
```bash
wget https://heplib.github.io/makefile 
make INSTALL_PATH=<Install Path> jn=16
```
**&lt;Install Path&gt;** refers to the path for the libraries to be installed to, **jn** is the number of jobs used in *make -j $jn*, try *make help* for more information.


External Libraries
------
Hint: Assuming one has exported the environment variable **INSTALL_PATH**
```bash
export INSTALL_PATH="<INSTALL PATH>"
```

+ **GMP**: it is required for **MPFR** and **GiNaC**.
```bash
#Typical installation instructions:
curl -L -O https://gmplib.org/download/gmp/gmp-6.2.0.tar.gz
tar zxf gmp-6.2.0.tar.gz
cd gmp-6.2.0
./configure --prefix=<INSTALL PATH> 
make -j 16
make install
```
+ **MPFR**: it is used to handle the multiple precision in the numerical integration when large number cancelation occurs. **MPFR** needs to be compiled with the option **--enable-float128**.
```bash
#Typical installation instructions:
curl -L -O https://heplib.github.io/download/mpfr-4.0.2.tar.gz
tar zxf mpfr-4.0.2.tar.gz
cd mpfr-4.0.2
./configure --prefix=<INSTALL PATH> --with-gmp=<INSTALL PATH> --enable-float128 --enable-thread-safe
make -j 16
make install
```

+ **CLN**: it is required for **GiNaC**
```bash
#Typical installation instructions:
curl -L -O https://www.ginac.de/CLN/cln-1.3.6.tar.bz2
tar jxf cln-1.3.6.tar.bz2
cd cln-1.3.6
./configure --prefix=<INSTALL PATH> --with-gmp=<INSTALL PATH>
make -j 16
make install
```

+ **GiNaC**: The underlying language of **HepLib**, which is used for symbolic operations and can be download from [https://www.ginac.de](https://www.ginac.de), its prerequisite **CLN** can be download from [https://www.ginac.de/CLN/](https://www.ginac.de/CLN/).
```bash
#Typical installation instructions:
curl -L -O https://www.ginac.de/ginac-1.7.11.tar.bz2
cd ginac-1.7.11
./configure --prefix=<INSTALL PATH> PKG_CONFIG_PATH=<INSTALL PATH>/lib/pkgconfig
make -j 16
make install
```

+ **Qgraf**: the version 3.1.4 has been included in **HepLib**, which can be download from [http://cfif.ist.utl.pt/~paulo/qgraf.html](http://cfif.ist.utl.pt/~paulo/qgraf.html).

+ **QHull**: it is used for sector decompostion with geometric stratage and available on [http://www.qhull.org](http://www.qhull.org).
```bash
#Typical installation instructions:
curl -L -O http://www.qhull.org/download/qhull-2020.2.zip
unzip -q qhull-2020.2.zip
cd qhull-2020.2
cp Makefile Makefile.bak
cat Makefile.bak | sed "s/\/usr\/local/<INSTALL PATH>/g" > Makefile
make
make install
```

+ **MinUit2**: it is used to find the minimum of a function, avaiable on [http://seal.web.cern.ch/seal/snapshot/work-packages/mathlibs/minuit/](http://seal.web.cern.ch/seal/snapshot/work-packages/mathlibs/minuit/).
```bash
#Typical installation instructions:
curl -L -O http://project-mathlibs.web.cern.ch/project-mathlibs/sw/5_34_14/Minuit2/Minuit2-5.34.14.tar.gz
cd Minuit2-5.34.14
./configure --prefix=<INSTALL PATH>
make -j 16
make install
```

+ **CUBA**: it is one of the numerical integrators and can be download from [http://www.feynarts.de/cuba/](http://www.feynarts.de/cuba/). 

    Note: The version with quadruple precision **libcubaq** is actually used, by adding the option **--with--real=16 CFLAGS="--fPIC -fcommon" CXXFLAGS="--fPIC -fcommon"** to the **configure** script.
```bash
#Typical installation instructions:
curl -L -O http://www.feynarts.de/cuba/Cuba-4.2.tar.gz
tar zxf Cuba-4.2.tar.gz
cd Cuba-4.2
./configure --prefix=<INSTALL PATH> --with-real=16 CFLAGS="-fPIC -fcommon" CXXFLAGS="-fPIC -fcommon"
make
make install
```
    
    
External binary Programs
------
It is only required that the binary programs can found in the environment variable **PATH**.

+ **FORM**: it is used for **Dirac** and **Color** matrix trace, Lorentz index contraction, *etc.*, it can be download from [https://www.nikhef.nl/~form/](https://www.nikhef.nl/~form/).

+ **Fermat**: it is used for high performance matrix operation, multivariate rational polynormial simplification, *etc.*, it can be download from [http://home.bway.net/lewis/](http://home.bway.net/lewis/).

+ **FIRE**: it is required for IBP reduction in **FIRE** class, it can be download from [https://bitbucket.org/feynmanIntegrals/fire/](https://bitbucket.org/feynmanIntegrals/fire/). 

    Note: **FIRE_Path/bin** needs to be added to the environment variable **PATH**.

+ **KIRA**: it is required for IBP reduction in **KIRA** class, it can be download from [https://kira.hepforge.org](https://kira.hepforge.org).


Compilation and Installation
------
One can download the most recent version of **HepLib** as a compressed archive: [HepLib.tar.gz](HepLib.tar.gz), uncompress it and change current directory into *HepLib/src* by the commands:
```bash
wget https://heplib.github.io/HepLib.tar.gz 
tar zxfv HepLib.tar.gz
cd HepLib/src
```
and create a directory for cmake to build the library as follows
```bash
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=<Install Path> .. 
make -j 4 && make install
```
where the standard cmake variable **CMAKE_INSTALL_PREFIX** refers to the directory to which **HepLib** will be installed, *i.e.*, the library *libHepLib.so* (the file name may be system dependent) will be installed to **&lt;Install Path&gt;/lib**, the related *C++* header files, including *HepLib.h*, *FC.h*, *SD.h*, *etc.*, will be installed to **&lt;Install Path&gt;/include**, the *binary programs*, including *heplib++*, *garview*, *etc.*, will be installed to **&lt;Install Path&gt;/bin**.

Hint: If **GiNaC** or other dependent external library is not installed to **CMAKE_INSTALL_PREFIX**, the user needs to specify the locations by supplying the variables **INC_PATH** and **LIB_PATH** in the cmake arguments as:
```bash
cmake -DCMAKE_INSTALL_PREFIX=path -DINC_PATH="inc1;inc2" -DLIB_PATH="lib1;lib2" ..
```
