#!/bin/bash

if [ -z $prefix ]; then
    export prefix=/usr/local
fi
export prefix

if [ -z $jn ]; then
    export jn=8
fi
export jn

export install_gmp='yes'
export install_mpfr='yes'
export install_cln='yes'
export install_ginac='yes'
export install_cuba='yes'
export install_minuit2='yes'
export install_qhull='yes'

export install_fermat='yes'
export install_form='yes'
export install_fire='yes'
export install_kira='yes'

export install_heplib='yes'

export CWD=$PWD
export LOG=$CWD/log.txt

# install GMP
if [ $install_gmp == 'yes' ]; then
    echo "Installing GMP ..."
    export pkg="gmp-6.2.0"
    if [ ! -f $pkg.tar.gz ]; then
        wget --no-check-certificate https://gmplib.org/download/gmp/$pkg.tar.gz
    fi
    rm -rf $pkg
    tar zxf $pkg.tar.gz
    cd $pkg
    ./configure --prefix=$prefix &>> $LOG
    make -j $jn &>> $LOG
    make install &>> $LOG
    cd $CWD
    rm -rf $pkg
    echo ""
fi

# install MPFR
if [ $install_mpfr == 'yes' ]; then
    echo "Installing MPFR ..."
    export pkg="mpfr-4.0.2"
    if [ ! -f $pkg.tar.gz ]; then
        wget --no-check-certificate https://heplib.github.io/download/$pkg.tar.gz
    fi
    rm -rf $pkg
    tar zxf $pkg.tar.gz
    cd $pkg
    if [ $install_gmp == 'yes' ]; then
        ./configure --prefix=$prefix --with-gmp=$prefix --enable-float128 --enable-thread-safe &>> $LOG
    else
        ./configure --prefix=$prefix --enable-float128 --enable-thread-safe &>> $LOG
    fi
    make -j $jn &>> $LOG
    make install &>> $LOG
    cd $CWD
    rm -rf $pkg
    echo ""
fi

# install CLN
if [ $install_cln == 'yes' ]; then
    echo "Installing CLN ..."
    export pkg="cln-1.3.6"
    if [ ! -f $pkg.tar.bz2 ]; then
        wget --no-check-certificate https://www.ginac.de/CLN/$pkg.tar.bz2
    fi
    rm -rf $pkg
    tar jxf $pkg.tar.bz2
    cd $pkg
    if [ $install_gmp == 'yes' ]; then
        ./configure --prefix=$prefix --with-gmp=$prefix &>> $LOG
    else
        ./configure --prefix=$prefix &>> $LOG
    fi
    make -j $jn &>> $LOG
    make install &>> $LOG
    cd $CWD
    rm -rf $pkg
    echo ""
fi

# install GiNaC
if [ $install_ginac == 'yes' ]; then
    echo "Install GiNaC ..."
    export pkg="ginac-1.7.11"
    if [ ! -f $pkg.tar.bz2 ]; then
        wget --no-check-certificate https://www.ginac.de/$pkg.tar.bz2
    fi
    rm -rf $pkg
    tar jxf $pkg.tar.bz2
    cd $pkg
    ./configure --prefix=$prefix PKG_CONFIG_PATH=$prefix/lib/pkgconfig &>> $LOG
    make -j $jn &>> $LOG
    make install &>> $LOG
    cd $CWD
    rm -rf $pkg
    echo ""
fi

# install CUBA
if [ $install_cuba == 'yes' ]; then
    echo "Install CUBA ..."
    export pkg="Cuba-4.2"
    if [ ! -f $pkg.tar.gz ]; then
        wget --no-check-certificate http://www.feynarts.de/cuba/$pkg.tar.gz
    fi
    rm -rf $pkg
    tar zxf $pkg.tar.gz
    cd $pkg
    ./configure --prefix=$prefix --with-real=16 CFLAGS="-fPIC -fcommon" CXXFLAGS="-fPIC -fcommon" &>> $LOG
    make &>> $LOG
    make install &>> $LOG
    cd $CWD
    rm -rf $pkg
    echo ""
fi

# install ROOT::Minuit2
if [ $install_minuit2 == 'yes' ]; then
    echo "Installing MinUit2 ..."
    export pkg="Minuit2-5.34.14"
    if [ ! -f $pkg.tar.gz ]; then
        wget --no-check-certificate http://www.cern.ch/mathlibs/sw/5_34_14/Minuit2/$pkg.tar.gz
    fi
    rm -rf $pkg
    tar zxf $pkg.tar.gz
    cd $pkg
    ./configure --prefix=$prefix &>> $LOG
    make -j $jn &>> $LOG
    make install &>> $LOG
    cd $CWD
    rm -rf $pkg
    echo ""
fi

# install QHull
if [ $install_qhull == 'yes' ]; then
    echo "Installing QHull ..."
    export pkg="qhull-2020.2"
    if [ ! -f $pkg.zip ]; then
        wget --no-check-certificate http://www.qhull.org/download/$pkg.zip
    fi
    rm -rf $pkg
    unzip -q $pkg.zip
    cd $pkg
    cp Makefile Makefile.bak
    cat Makefile.bak | sed "s/\/usr\/local/\$\$prefix/g" > Makefile
    make &>> $LOG
    make install &>> $LOG
    cd $CWD
    rm -rf $pkg
    echo ""
fi

# install Fermat
if [ $install_fermat == 'yes' ]; then
    echo "Installing Fermat ..."
    uo="$(uname -s)"
    case "${uo}" in
        Linux*)     pkg="ferl6";;
        Darwin*)    pkg="ferm6";;
    esac
    export pkg
    if [ ! -f $pkg.tar.gz ]; then
        wget --no-check-certificate http://home.bway.net/lewis/fermat64/$pkg.tar.gz
    fi
    rm -rf $pkg
    tar zxf $pkg.tar.gz
    rm -rf $prefix/$pkg
    mv $pkg $prefix/
    cd "$prefix/bin"
    ln -s -f ../$pkg/fer64 .
    cd $CWD
    echo ""
fi

# install Form
if [ $install_form == 'yes' ]; then
    echo "Install FORM ..."
    uo="$(uname -s)"
    case "${uo}" in
        Linux*)     pkg="form-4.2.1-x86_64-linux";;
        Darwin*)    pkg="form-4.2.1-x86_64-osx";;
    esac
    export pkg
    if [ ! -f $pkg.tar.gz ]; then
        wget --no-check-certificate https://github.com/vermaseren/form/releases/download/v4.2.1/$pkg.tar.gz
    fi
    tar zxf $pkg.tar.gz
    cp -rf $pkg/form "$prefix/bin/"
    cp -rf $pkg/tform "$prefix/bin/"
    rm -rf $pkg
    cd $CWD
    echo ""
fi

# install FIRE
if [ $install_fire == 'yes' ]; then
    echo "Installing FIRE ..."
    rm -rf fire
    git clone https://bitbucket.org/feynmanIntegrals/fire.git
    rm -rf $prefix/FIRE6
    mv fire/FIRE6 $prefix/FIRE6
    rm -rf fire
    cd $prefix/FIRE6
    ./configure --enable_zlib --enable_snappy --enable_lthreads --enable_tcmalloc --enable_zstd &>> $LOG
    make -j $jn dep &>> $LOG
    mkdir -p usr/include
    cp -f extra/lz4-*/lib/*.h usr/include/
    cp -f extra/lz4-*/lib/liblz4.a usr/lib/
    make &>> $LOG
    cd $CWD
    echo ""
fi

# install KIRA
if [ $install_kira == 'yes' ]; then
    uo="$(uname -s)"
    case "${uo}" in
        Linux*)     pkg="Linux";;
        Darwin*)    pkg="MacOS";;
    esac
    export pkg
    if [ $pkg == "Linux" ]; then
        rm -rf kira
        wget --no-check-certificate -O kira https://kira.hepforge.org/downloads?f=binaries/kira-2.0
        chmod +x kira
        mv -f kira "$prefix/bin/kira"
    fi
    cd $CWD
    echo ""
fi

# install HepLib
if [ $install_heplib == 'yes' ]; then
    echo "Installing HepLib ..."
    export pkg="HepLib"
    if [ ! -f $pkg.tar.gz ]; then
        wget --no-check-certificate https://heplib.github.io/HepLib.tar.gz
    fi
    rm -rf HepLib examples
    tar zxf $pkg.tar.gz
    cd $pkg
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=$prefix ..
    make -j $jn
    make install 
    cd $CWD
    rm -rf $pkg
    echo ""
fi

echo ""
echo "Installation Completed!"
echo "You can add the following sentences to your .bashrc" 
echo ""
echo "export PATH=$prefix/bin:$prefix/FIRE6/bin:\$PATH"
echo "export LD_LIBRARY_PATH=$prefix/lib:\$LD_LIBRARY_PATH"
echo

