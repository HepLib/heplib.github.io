Installation of HepLib
===
**HepLib** uses a few external routines or libraries, one needs to install these required libraries before the installation of **HepLib**. An install script is provided for automatic installation of these required libraries and **HepLib** itself, one can also install the external libraries and binary programs, and compile **HepLib** manually.

Install Script
---
The shell script [install.sh](install.sh) can be used in install the external libraries and **HepLib**, by typing the commands in the terminal:
```bash
wget https://heplib.github.io/install.sh 
chmod +x install.sh
prefix=<Install Path> jn=16 ./install.sh
```
`<Install Path>` refers to the path for the libraries to be installed to, and `jn` is the number of jobs used in `make -j $jn`.

External Libraries
---
+ **GiNaC**: the underlying language of **HepLib**, which is used for symbolic operations and can be download from [https://www.ginac.de](https://www.ginac.de), and its prerequisite **CLN** can be download from [https://www.ginac.de/CLN/](https://www.ginac.de/CLN/).

+ **Qgraf**: the version 3.1.4 has been included in **HepLib**, which can be download form [http://cfif.ist.utl.pt/~paulo/qgraf.html](http://cfif.ist.utl.pt/~paulo/qgraf.html).

+ **QHull**: it is used for sector decompostion with geometric stratage and available on[http://www.qhull.org](http://www.qhull.org).

+ **MinUit2**: it is used to find the minimum of a function, avaiable on [http://seal.web.cern.ch/seal/snapshot/work-packages/mathlibs/minuit/](http://seal.web.cern.ch/seal/snapshot/work-packages/mathlibs/minuit/).

+ **CUBA**: it is one of the numerical integrators and can be download from [http://www.feynarts.de/cuba/](http://www.feynarts.de/cuba/), note that the version with quadruple precision **libcubaq** will be used, by adding the option `--with--real=16 CFLAGS="--fPIC" CXXFLAGS="--fPIC"` to the `configure` script.
    
External binary Programs
---
It is only required that the binary programs can found in the environment variable `PATH`.

+ **FORM**: it is used for `Dirac` and `Color` matrix trace, Lorentz index contraction, *etc.*, it can be download form [https://www.nikhef.nl/~form/](https://www.nikhef.nl/~form/).

+ **Fermat**: it is used form high performance matrix operation, multivariate rational polynormial simplification, *etc.*, it can be download from [http://home.bway.net/lewis/](http://home.bway.net/lewis/).

+ **FIRE**: it is required for IBP reduction in `FIRE` class, it can be download from [https://bitbucket.org/feynmanIntegrals/fire/](https://bitbucket.org/feynmanIntegrals/fire/). Note that `FIRE_Path/bin` needs to be added to the environment variable `PATH`.

+ **KIRA**: it is required for IBP reduction in `KIRA` class, it can be download from [https://kira.hepforge.org](https://kira.hepforge.org).

Compilation and Installation
---
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
where the standard cmake variable `CMAKE_INSTALL_PREFIX` refers to the directory to which HepLib will be installed, i.e., the library libHepLib.so (the file name may be system dependent) will be installed to `<Install Path>/lib`, the related C++ header files, including `HepLib.h`, `FC.h`, `SD.h`, etc., will be installed to `<Install Path>/include`, and the binary programs, including `heplib++`, `garview`, *etc.*, will be installed to `<Install Path>/bin`.
If **GiNaC** or other dependent external library is not installed to `CMAKE_INSTALL_PREFIX`, the user needs to specify the locations by supplying the variables `INC_PATH `and `LIB_PATH` in the cmake arguments as:
```bash
cmake -DCMAKE_INSTALL_PREFIX=path -DINC_PATH="inc1;inc2" -DLIB_PATH="lib1;lib2" ..
```
