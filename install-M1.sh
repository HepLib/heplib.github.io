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
# brew
#================================================================
brew install gmp
brew install mpfr
brew install qhull
brew install flint
brew install arb
brew install texinfo

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
CPPFLAGS="-DNO_ASM" ./configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH >>$LOG 2>>$LOG
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
# Install FIRE - Modified version
#================================================================
export pkg="FIRE6"
echo "Installing $pkg ..."
$dlcmd -o $pkg.tar.gz https://heplib.github.io/$pkg.tar.gz
tar zxf $pkg.tar.gz
mv -f $pkg "$INSTALL_PATH/$pkg"
cd "$INSTALL_PATH/$pkg"
make -f Makefile.M1 -j $jn dep >>$LOG 2>>$LOG
make -f Makefile.M1 >>$LOG 2>>$LOG
make -f Makefile.M1 cleandep >>$LOG 2>>$LOG
make -f Makefile.M1 clean >>$LOG 2>>$LOG
cd $CWD
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
# Install HepLib
#================================================================
export pkg="HepLib"
echo "Installing $pkg ..."
if [ ! -f $pkg.tar.gz ]; then
    $dlcmd -o HepLib.tar.gz https://heplib.github.io/HepLib.tar.gz
fi
rm -rf $pkg
tar zxf $pkg.tar.gz
cd $pkg
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH ..
make -j $jn
make install
cd $CWD
rm -rf $pkg
echo ""

echo ""
echo "Installation Completed!"
echo ""

