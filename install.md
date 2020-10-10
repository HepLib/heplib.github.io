Installation of HepLib
======
Note: **HepLib** uses several external routines or libraries, one needs to install these required libraries before the installation of **HepLib**. An install script is provided for automatic installation of these required libraries and **HepLib** itself, one can also install the external libraries and binary programs and compile **HepLib** manually.


Install Script (All in One)
------
The shell script [install.sh](install.sh) can be used to install **HepLib** as well as external libraries/programs, by typing the commands in the terminal:
```bash
wget https://heplib.github.io/install.sh 
chmod +x install.sh
INSTALL_PATH=<INSTALL PATH> jn=16 ./install.sh
```
**&lt;INSTALL PATH&gt;** refers to the path for the libraries to be installed to, **jn** is the number of jobs used in *make -j $jn*.


Install Makefile (All in One)
------
The  [makefile](makefile) can also be used to install **HepLib** as well as external libraries/programs, by typing the commands in the terminal:
```bash
wget https://heplib.github.io/makefile 
make INSTALL_PATH=<INSTALL PATH> jn=16
```
**&lt;INSTALL PATH&gt;** refers to the path for the libraries to be installed to, **jn** is the number of jobs used in *make -j $jn*, try *make help* for more information.


Manual Installation
------

- *External Libraries*

    Hint: Assuming one has exported the environment variable **INSTALL_PATH**
    $ export INSTALL_PATH="&lt;INSTALL PATH&gt;"

    + [**GMP**](https://gmplib.org/): it is required for **MPFR** and **GiNaC**.
```bash
#Typical installation instructions:
curl -L -O https://gmplib.org/download/gmp/gmp-6.2.0.tar.gz
tar zxf gmp-6.2.0.tar.gz
cd gmp-6.2.0
./configure --prefix=$INSTALL_PATH 
make -j 16
make install
```
    + [**MPFR**](https://www.mpfr.org/): it is used to handle the multiple precision in the numerical integration when large number cancelation occurs. **MPFR** needs to be compiled with the option **--enable-float128**.
        
        Note: The quadruple precision type __float128 has been changed to _Float128 since [MPFR 4.1.0](https://www.mpfr.org/mpfr-4.1.0/), so we prefer the version [MPFR 4.0.2](https://heplib.github.io/download/mpfr-4.0.2.tar.gz) for the moment, furthermore the [MPFR C++](http://www.holoborodko.com/pavel/mpfr/) wrapper is included in **HepLib** archive.
```bash
#Typical installation instructions:
curl -L -O https://heplib.github.io/download/mpfr-4.0.2.tar.gz
tar zxf mpfr-4.0.2.tar.gz
cd mpfr-4.0.2
./configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --enable-float128 --enable-thread-safe
make -j 16
make install
```

    + [**CLN**](https://www.ginac.de/CLN/): it is required for **GiNaC**.
```bash
#Typical installation instructions:
curl -L -O https://www.ginac.de/CLN/cln-1.3.6.tar.bz2
tar jxf cln-1.3.6.tar.bz2
cd cln-1.3.6
./configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH
make -j 16
make install
```

    + [**GiNaC**](https://www.ginac.de): The underlying language of **HepLib**, which is used for symbolic operations.
```bash
#Typical installation instructions:
curl -L -O https://www.ginac.de/ginac-1.7.11.tar.bz2
cd ginac-1.7.11
./configure --prefix=$INSTALL_PATH PKG_CONFIG_PATH=$INSTALL_PATH/lib/pkgconfig
make -j 16
make install
```

    + [**QHull**](http://www.qhull.org): it is used for sector decompostion with geometric strategy.
```bash
#Typical installation instructions:
curl -L -O http://www.qhull.org/download/qhull-2020.2.zip
unzip -q qhull-2020.2.zip
cd qhull-2020.2
cp Makefile Makefile.bak
cat Makefile.bak | sed "s/\/usr\/local/\$\$INSTALL_PATH/g" > Makefile
make
make install
```

    + [**MinUit2**](http://seal.web.cern.ch/seal/snapshot/work-packages/mathlibs/minuit/): it is used to find the minimum of a function.
```bash
#Typical installation instructions:
curl -L -O http://project-mathlibs.web.cern.ch/project-mathlibs/sw/5_34_14/Minuit2/Minuit2-5.34.14.tar.gz
cd Minuit2-5.34.14
./configure --prefix=$INSTALL_PATH
make -j 16
make install
```

    + [**CUBA**](http://www.feynarts.de/cuba/): it is one of the numerical integrators. 

        Note: The version with quadruple precision **libcubaq** is actually used, by adding the option **--with--real=16 CFLAGS="--fPIC -fcommon" CXXFLAGS="--fPIC -fcommon"** to the **configure** script.
```bash
#Typical installation instructions:
curl -L -O http://www.feynarts.de/cuba/Cuba-4.2.tar.gz
tar zxf Cuba-4.2.tar.gz
cd Cuba-4.2
./configure --prefix=$INSTALL_PATH --with-real=16 CFLAGS="-fPIC -fcommon" CXXFLAGS="-fPIC -fcommon"
make
make install
```
    

- External binary Programs

    It is only required that the binary programs can found in the environment variable **PATH**.

    Hint: Assuming one has exported the environment variable **INSTALL_PATH**
    $ export INSTALL_PATH="&lt;INSTALL PATH&gt;"

    + [**Fermat**](http://home.bway.net/lewis/): it is used for matrix operation, multivariate rational polynormial simplification, *etc.*.
```bash
#Typical installation instructions (Linux OS):
curl -L -O http://home.bway.net/lewis/fermat64/ferl6.tar.gz
tar zxf ferl6.tar.gz
mv ferl6 $INSTALL_PATH
cd $INSTALL_PATH/bin
ln -s -f ../ferl6/fer64 .
```
```bash
#Typical installation instructions (MacOS):
curl -L -O http://home.bway.net/lewis/fermat64/ferlm.tar.gz
tar zxf ferm6.tar.gz
mv ferm6 $INSTALL_PATH
ln -s -f ../ferm6/fer64 .
```

    + [**FORM**](https://www.nikhef.nl/~form/): it is used for *Dirac* and *Color* matrix trace, Lorentz index contraction, *etc.*.
```bash
#Typical installation instructions (Linux OS):
curl -L -O https://github.com/vermaseren/form/releases/download/v4.2.1/form-4.2.1-x86_64-linux.tar.gz
tar zxf form-4.2.1-x86_64-linux.tar.gz
cp -rf form-4.2.1-x86_64-linux/form $INSTALL_PATH/bin/
cp -rf form-4.2.1-x86_64-linux/tform $INSTALL_PATH/bin/
```
```bash
#Typical installation instructions (MacOS):
curl -L -O https://github.com/vermaseren/form/releases/download/v4.2.1/form-4.2.1-x86_64-osx.tar.gz
tar zxf form-4.2.1-x86_64-osx.tar.gz
cp -rf form-4.2.1-x86_64-osx/form $INSTALL_PATH/bin/
cp -rf form-4.2.1-x86_64-osx/tform $INSTALL_PATH/bin/
```

    + [**FIRE**](https://bitbucket.org/feynmanIntegrals/fire/): it is required for IBP reduction in **FIRE** class. 

        Note: **FIRE_Path/bin** needs to be added to the environment variable **PATH**.
```bash
#Typical installation instructions:
git clone https://bitbucket.org/feynmanIntegrals/fire.git
mv fire/FIRE6 $INSTALL_PATH/FIRE6
rm -rf fire
cd $INSTALL_PATH/FIRE6
./configure --enable_zlib --enable_snappy --enable_lthreads --enable_tcmalloc --enable_zstd
make -j 16
make
```

    + [**KIRA**](https://kira.hepforge.org): it is required for IBP reduction in **KIRA** class.
```bash
#Typical installation instructions (Linux OS):
curl -L -o kira https://kira.hepforge.org/downloads?f=binaries/kira-2.0
chmod +x kira
mv -f kira $INSTALL_PATH/bin/kira
```

- Compilation and Installation

    Hint: Assuming one has exported the environment variable **INSTALL_PATH**
    $ export INSTALL_PATH="&lt;INSTALL PATH&gt;"

    One can download the most recent version of **HepLib** as a compressed archive: [HepLib.tar.gz](HepLib.tar.gz), uncompress it and change current directory into *HepLib/src* by the commands:
```bash
wget https://heplib.github.io/HepLib.tar.gz 
tar zxfv HepLib.tar.gz
cd HepLib/src
```
    and create a directory for cmake to build the library as follows
```bash
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH .. 
make -j 4 && make install
```
    where the standard cmake variable **CMAKE_INSTALL_PREFIX** refers to the directory to which **HepLib** will be installed, *i.e.*, the library *libHepLib.so* (the file name may be system dependent) will be installed to **$INSTALL_PATH/lib**, the related *C++* header files, including *HepLib.h*, *FC.h*, *SD.h*, *etc.*, will be installed to **$INSTALL_PATH/include**, the *binary programs*, including *heplib++*, *garview*, *etc.*, will be installed to **$INSTALL_PATH/bin**.

    Hint: If **GiNaC** or other dependent external library is not installed to **CMAKE_INSTALL_PREFIX**, the user needs to specify the locations by supplying the variables **INC_PATH** and **LIB_PATH** in the cmake arguments as:
```bash
cmake -DCMAKE_INSTALL_PREFIX=path -DINC_PATH="inc1;inc2" -DLIB_PATH="lib1;lib2" ..
```
