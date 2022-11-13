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

#================================================================
# Install GMP
#================================================================
export pkg="gmp-6.2.1"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.bz2 ]; then
    $dlcmd -o $pkg.tar.bz2 https://heplib.github.io/$pkg.tar.bz2
fi
rm -rf $pkg
tar jxf $pkg.tar.bz2
cd $pkg
./configure --prefix=$INSTALL_PATH --enable-cxx >>$LOG 2>>$LOG
make -j $jn >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

#================================================================
# Install MPFR
#================================================================
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

#================================================================
# Install CLN
#================================================================
export pkg="cln-1.3.6"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.bz2 ]; then
    $dlcmd -o $pkg.tar.bz2 https://heplib.github.io/$pkg.tar.bz2
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

#================================================================
# Install GiNaC - Modified version
#================================================================
export pkg="GiNaC"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz https://heplib.github.io/$pkg.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg
./configure --prefix=$INSTALL_PATH PKG_CONFIG_PATH=$INSTALL_PATH/lib/pkgconfig >>$LOG 2>>$LOG
make -j $jn >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

#================================================================
# Install QHull
#================================================================
export pkg="qhull-2020.2"
echo "Installing $pkg ..."
if [ ! -f $pkg.zip ]; then
    $dlcmd -o $pkg.zip https://heplib.github.io/$pkg.zip
fi
rm -rf $pkg
unzip -q $pkg.zip
cd $pkg
make PREFIX=$INSTALL_PATH >>$LOG 2>>$LOG
make PREFIX=$INSTALL_PATH install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

#================================================================
# Install FLINT
#================================================================
export pkg="flint-2.9.0"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz https://heplib.github.io/$pkg.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg
./configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --with-mpfr=$INSTALL_PATH >>$LOG 2>>$LOG
make -j $jn >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

#================================================================
# Install ARB
#================================================================
export pkg="arb-2.23.0"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz https://heplib.github.io/$pkg.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg
./configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --with-mpfr=$INSTALL_PATH --with-flint=$INSTALL_PATH >>$LOG 2>>$LOG
make -j $jn >>$LOG 2>>$LOG
make install >>$LOG 2>>$LOG
cd $CWD
rm -rf $pkg
echo ""

#================================================================
# Install Fermat
#================================================================
echo "Installing Fermat ..."
uo="$(uname -s)"
case "${uo}" in
    Linux*)     pkg="ferl6";;
    Darwin*)    pkg="ferm6";;
esac
export pkg
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz https://heplib.github.io/$pkg.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
rm -rf $INSTALL_PATH/$pkg
mv $pkg $INSTALL_PATH/
cd "$INSTALL_PATH/bin"
ln -s -f ../$pkg/fer64 .
cd $CWD
echo ""

#================================================================
# Install Form
#================================================================
uo="$(uname -s)"
case "${uo}" in
    Linux*)     pkg="form-4.2.1-x86_64-linux";;
    Darwin*)    pkg="form-4.2.1-x86_64-osx";;
esac
export pkg
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o $pkg.tar.gz https://heplib.github.io/$pkg.tar.gz
fi
tar zxf $pkg.tar.gz
cp -rf $pkg/form "$INSTALL_PATH/bin/"
cp -rf $pkg/tform "$INSTALL_PATH/bin/"
rm -rf $pkg
cd $CWD
echo ""

#================================================================
# Install FIRE - Modified version
#================================================================
export pkg="FIRE6"
echo "Installing $pkg ..."
$dlcmd -o $pkg.tar.gz https://heplib.github.io/$pkg.tar.gz
tar zxf $pkg.tar.gz
mv -f $pkg "$INSTALL_PATH/$pkg"
cd "$INSTALL_PATH/$pkg"
make -j $jn dep >>$LOG 2>>$LOG
make >>$LOG 2>>$LOG
make cleandep >>$LOG 2>>$LOG
make clean >>$LOG 2>>$LOG
cd $CWD
echo ""

#================================================================
# Install HepLib
#================================================================
export pkg="HepLib"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o HepLib.tar.gz https://heplib.github.io/HepLib.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg/src
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH ..
make -j $jn
make install 
cd $CWD
echo ""

echo ""
echo "Installation Completed!"
echo ""


