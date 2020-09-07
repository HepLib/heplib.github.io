#!/bin/bash

if [ -z $INSTALL_PATH ]; then
    INSTALL_PATH=/usr/local
fi
export INSTALL_PATH

# for old version with prefix
if [ ! -z $prefix ]; then
    INSTALL_PATH=$prefix
    unset prefix
fi
export INSTALL_PATH
echo $prefix
echo $INSTALL_PATH
exit 0

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
        curl -O https://gmplib.org/download/gmp/$pkg.tar.gz
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
fi

# install MPFR
if [ $install_mpfr == 'yes' ]; then
    echo "Installing MPFR ..."
    export pkg="mpfr-4.0.2"
    if [ ! -f $pkg.tar.gz ]; then
        curl -O https://heplib.github.io/download/$pkg.tar.gz
    fi
    rm -rf $pkg
    tar zxf $pkg.tar.gz
    cd $pkg
    if [ $install_gmp == 'yes' ]; then
        ./configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH --enable-float128 --enable-thread-safe >>$LOG 2>>$LOG
    else
        ./configure --prefix=$INSTALL_PATH --enable-float128 --enable-thread-safe >>$LOG 2>>$LOG
    fi
    make -j $jn >>$LOG 2>>$LOG
    make install >>$LOG 2>>$LOG
    cd $CWD
    rm -rf $pkg
    echo ""
fi

# install CLN
if [ $install_cln == 'yes' ]; then
    echo "Installing CLN ..."
    export pkg="cln-1.3.6"
    if [ ! -f $pkg.tar.bz2 ]; then
        curl -O https://www.ginac.de/CLN/$pkg.tar.bz2
    fi
    rm -rf $pkg
    tar jxf $pkg.tar.bz2
    cd $pkg
    if [ $install_gmp == 'yes' ]; then
        ./configure --prefix=$INSTALL_PATH --with-gmp=$INSTALL_PATH >>$LOG 2>>$LOG
    else
        ./configure --prefix=$INSTALL_PATH >>$LOG 2>>$LOG
    fi
    make -j $jn >>$LOG 2>>$LOG
    make install >>$LOG 2>>$LOG
    cd $CWD
    rm -rf $pkg
    echo ""
fi

# install GiNaC
if [ $install_ginac == 'yes' ]; then
    echo "Install GiNaC ..."
    export pkg="ginac-1.7.11"
    if [ ! -f $pkg.tar.bz2 ]; then
        curl -O https://www.ginac.de/$pkg.tar.bz2
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
fi

# install CUBA
if [ $install_cuba == 'yes' ]; then
    echo "Install CUBA ..."
    export pkg="Cuba-4.2"
    if [ ! -f $pkg.tar.gz ]; then
        curl -O http://www.feynarts.de/cuba/$pkg.tar.gz
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
fi

# install ROOT::Minuit2
if [ $install_minuit2 == 'yes' ]; then
    echo "Installing MinUit2 ..."
    export pkg="Minuit2-5.34.14"
    if [ ! -f $pkg.tar.gz ]; then
        curl -O http://project-mathlibs.web.cern.ch/project-mathlibs/sw/5_34_14/Minuit2/$pkg.tar.gz
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
fi

# install QHull
if [ $install_qhull == 'yes' ]; then
    echo "Installing QHull ..."
    export pkg="qhull-2020.2"
    if [ ! -f $pkg.zip ]; then
        curl -O http://www.qhull.org/download/$pkg.zip
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
        curl -O http://home.bway.net/lewis/fermat64/$pkg.tar.gz
    fi
    rm -rf $pkg
    tar zxf $pkg.tar.gz
    rm -rf $INSTALL_PATH/$pkg
    mv $pkg $INSTALL_PATH/
    cd "$INSTALL_PATH/bin"
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
        curl -O https://github.com/vermaseren/form/releases/download/v4.2.1/$pkg.tar.gz
    fi
    tar zxf $pkg.tar.gz
    cp -rf $pkg/form "$INSTALL_PATH/bin/"
    cp -rf $pkg/tform "$INSTALL_PATH/bin/"
    rm -rf $pkg
    cd $CWD
    echo ""
fi

# install FIRE
if [ $install_fire == 'yes' ]; then
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
        curl -o kira https://kira.hepforge.org/downloads?f=binaries/kira-2.0
        chmod +x kira
        mv -f kira "$INSTALL_PATH/bin/kira"
    fi
    if [ $pkg == "MacOS" ]; then
        rm -rf kira
        curl -o kira-2.0.tar.gz https://kira.hepforge.org/downloads?f=kira-2.0.tar.gz
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
fi

# install HepLib
if [ $install_heplib == 'yes' ]; then
    echo "Installing HepLib ..."
    export pkg="HepLib"
    if [ ! -f $pkg.tar.gz ]; then
        curl -O https://heplib.github.io/HepLib.tar.gz
    fi
    rm -rf HepLib examples
    tar zxf $pkg.tar.gz
    cd $pkg
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH ..
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
echo "export PATH=$INSTALL_PATH/bin:$INSTALL_PATH/FIRE6/bin:\$PATH"
echo "export LD_LIBRARY_PATH=$INSTALL_PATH/lib:\$LD_LIBRARY_PATH"
echo

