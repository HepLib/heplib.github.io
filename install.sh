#!/bin/bash

export CC=gcc
export CXX=g++
export dlcmd='curl -k -L'

if [ -z $INSTALL_PATH ]; then
    INSTALL_PATH=/usr/local/heplib
fi
export INSTALL_PATH

if [ -z $jn ]; then
    export jn=8
fi
export jn

export CWD=$PWD
export LOG=$CWD/log.txt

# install GMP
export pkg="gmp-6.2.1"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz https://gmplib.org/download/gmp/$pkg.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg
./configure --prefix=$INSTALL_PATH >>$LOG 2>>$LOG
make -j $jn >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

# install MPFR
export pkg="mpfr-4.0.2"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz https://heplib.github.io/$pkg.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg
./configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --enable-float128 --enable-thread-safe >>$LOG 2>>$LOG
make -j $jn >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

# install CLN
export pkg="cln-1.3.6"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.bz2 ]; then
    $dlcmd -o $pkg.tar.bz2 https://www.ginac.de/CLN/$pkg.tar.bz2
fi
rm -rf $pkg
tar jxf $pkg.tar.bz2
cd $pkg
./configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH >>$LOG 2>>$LOG
make -j $jn >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

# install GiNaC
export pkg="ginac-1.8.0"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.bz2 ]; then
    $dlcmd -o $pkg.tar.bz2 https://www.ginac.de/$pkg.tar.bz2
fi
rm -rf $pkg
tar jxf $pkg.tar.bz2
cd $pkg
./configure --prefix=$INSTALL_PATH PKG_CONFIG_PATH=$INSTALL_PATH/lib/pkgconfig >>$LOG 2>>$LOG
make -j $jn >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

# install CUBA
export pkg="Cuba-4.2"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz http://www.feynarts.de/cuba/$pkg.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg
./configure --prefix=$INSTALL_PATH --with-real=16 CFLAGS="-fPIC -fcommon" CXXFLAGS="-fPIC -fcommon" >>$LOG 2>>$LOG
make >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

# install ROOT::Minuit2
export pkg="Minuit2-5.34.14"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz http://project-mathlibs.web.cern.ch/project-mathlibs/sw/5_34_14/Minuit2/$pkg.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg
./configure --prefix=$INSTALL_PATH >>$LOG 2>>$LOG
make -j $jn >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

# install QHull
export pkg="qhull-2020.2"
echo "Installing $pkg ..."
if [ ! -f $pkg.zip ]; then
    $dlcmd -o $pkg.zip http://www.qhull.org/download/$pkg.zip
fi
rm -rf $pkg
unzip -q $pkg.zip
cd $pkg
cp Makefile Makefile.bak
cat Makefile.bak | sed "s/\/usr\/local/\$\$INSTALL_PATH/g" > Makefile
make >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

# install Fermat
echo "Installing Fermat ..."
uo="$(uname -s)"
case "${uo}" in
    Linux*)     pkg="ferl6";;
    Darwin*)    pkg="ferm6";;
esac
export pkg
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz http://home.bway.net/lewis/fermat64/$pkg.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
rm -rf $INSTALL_PATH/$pkg
mv $pkg $INSTALL_PATH/
cd "$INSTALL_PATH/bin"
ln -s -f ../$pkg/fer64 .
cd $CWD
echo ""

# install Form
uo="$(uname -s)"
case "${uo}" in
    Linux*)     pkg="form-4.2.1-x86_64-linux";;
    Darwin*)    pkg="form-4.2.1-x86_64-osx";;
esac
export pkg
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz https://github.com/vermaseren/form/releases/download/v4.2.1/$pkg.tar.gz
fi
tar zxf $pkg.tar.gz
cp -rf $pkg/form "$INSTALL_PATH/bin/"
cp -rf $pkg/tform "$INSTALL_PATH/bin/"
rm -rf $pkg
cd $CWD
echo ""

# install FIRE
echo "Installing FIRE ..."
rm -rf fire
git clone https://bitbucket.org/feynmanIntegrals/fire.git
rm -rf $INSTALL_PATH/FIRE6
mv fire/FIRE6 $INSTALL_PATH/FIRE6
rm -rf fire
cd $INSTALL_PATH/FIRE6
./configure --enable_zlib --enable_snappy --enable_lthreads --enable_tcmalloc --enable_zstd >>$LOG 2>>$LOG
make -j $jn dep >>$LOG 2>>$LOG
make >>$LOG 2>>$LOG
cd $CWD
echo ""

# install KIRA
uo="$(uname -s)"
case "${uo}" in
    Linux*)     pkg="Linux";;
    Darwin*)    pkg="MacOS";;
esac
export pkg
if [ $pkg == "Linux" ]; then
    rm -rf kira
    $dlcmd -o kira https://kira.hepforge.org/downloads?f=binaries/kira-2.0
    chmod +x kira
    mv -f kira "$INSTALL_PATH/bin/kira"
fi
if [ $pkg == "MacOS" ]; then
    rm -rf kira
    $dlcmd -o kira-2.0.tar.gz https://kira.hepforge.org/downloads?f=kira-2.0.tar.gz
    tar zxf kira-2.0.tar.gz
    cd kira-2.0
    pip3 install --user meson
    meson -Dfirefly=false --prefix=$INSTALL_PATH --wrap-mode=forcefallback builddir
    cd builddir
    ninja
    ninja install
fi
cd $CWD
echo ""

# install HepLib
export pkg="HepLib"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o HepLib.tar.gz https://heplib.github.io/HepLib.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg/src
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH ..
make -j $jn
make install 
cd $CWD
echo ""

echo ""
echo "Installation Completed!"
echo ""


