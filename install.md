Installation of HepLib
======
Note: **HepLib** uses a few external routines or libraries, one needs to install these required libraries before the installation of **HepLib**. An install script is provided for automatic installation of these required libraries and **HepLib** itself, one can also install the external libraries and binary programs and compile **HepLib** manually.


Install Script (All in One)
------
The shell script [install.sh](install.sh) can be used to install **HepLib** as well as external libraries/programs, by typing the commands in the terminal:
```bash
wget https://heplib.github.io/install.sh 
chmod +x install.sh
prefix=<Install Path> jn=16 ./install.sh
```
**&lt;Install Path&gt;** refers to the path for the libraries to be installed to, **jn** is the number of jobs used in *make -j $jn*.


Install Makefile (All in One)
------
The  [makefile](makefile.sh) can also be used to install **HepLib** as well as external libraries/programs, by typing the commands in the terminal:
```bash
wget https://heplib.github.io/makefile 
make prefix=<Install Path> jn=16
```
**&lt;Install Path&gt;** refers to the path for the libraries to be installed to, **jn** is the number of jobs used in *make -j $jn*.


External Libraries
------
+ **GiNaC**: the underlying language of **HepLib**, which is used for symbolic operations and can be download from [https://www.ginac.de](https://www.ginac.de), its prerequisite **CLN** can be download from [https://www.ginac.de/CLN/](https://www.ginac.de/CLN/).

+ **Qgraf**: the version 3.1.4 has been included in **HepLib**, which can be download from [http://cfif.ist.utl.pt/~paulo/qgraf.html](http://cfif.ist.utl.pt/~paulo/qgraf.html).

+ **MPFR**: it is used to handle the multiple precision in the numerical integration when large number cancelation occurs. **MPFR** needs to be compiled with the option **--enable-float128**. **GMP** is required for **MPFR**, usually it has already been installed in one’s computer. Both libraries can be obtained from GNU site. 
    
    Note:  The quadruple precision type **__float128** has been changed to
**_Float128** since [MPFR 4.1.0](https://www.mpfr.org/mpfr-4.1.0/), so we prefer the version [MPFR 4.0.2](download/mpfr-4.0.2.tar.gz) for the moment, furthermore the [MPFR C++](http://www.holoborodko.com/pavel/mpfr/) wrapper is included in **HepLib** archive.

+ **QHull**: it is used for sector decompostion with geometric stratage and available on [http://www.qhull.org](http://www.qhull.org).

+ **MinUit2**: it is used to find the minimum of a function, avaiable on [http://seal.web.cern.ch/seal/snapshot/work-packages/mathlibs/minuit/](http://seal.web.cern.ch/seal/snapshot/work-packages/mathlibs/minuit/).

+ **CUBA**: it is one of the numerical integrators and can be download from [http://www.feynarts.de/cuba/](http://www.feynarts.de/cuba/). 

    Note: The version with quadruple precision **libcubaq** is actually used, by adding the option **--with--real=16 CFLAGS="--fPIC -fcommon" CXXFLAGS="--fPIC -fcommon"** to the **configure** script.
    
    
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
One can download the most recent version of **HepLib** as a compressed archive: [HepLib.tar.gz](HepLib.tar.gz), uncompress it and change current directory into *HepLib* by the commands:
```bash
wget https://heplib.github.io/HepLib.tar.gz 
tar zxfv HepLib.tar.gz
cd HepLib
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
