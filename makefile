all : install

UNAMES := $(shell uname -s)
ifeq ($(UNAMES),Linux)
    Fermat = ferm6.tar.gz
    fermat = $(basename $(basename ${Fermat}))
    FORM = form-4.2.1-x86_64-linux.tar.gz
    form = $(basename $(basename ${FORM}))
endif
ifeq ($(UNAMES),Darwin)
    Fermat = ferml.tar.gz
    FORM = form-4.2.1-x86_64-osx.tar.gz
endif
 
GMP = gmp-6.2.0.tar.gz
gmp = $(basename $(basename ${GMP}))
MPFR = mpfr-4.0.2.tar.gz
mpfr = $(basename $(basename ${MPFR}))
CLN = cln-1.3.6.tar.bz2
cln = $(basename $(basename ${CLN}))
GINAC = ginac-1.7.11.tar.bz2
ginac = $(basename $(basename ${GINAC}))
CUBA = Cuba-4.2.tar.gz
cuba = $(basename $(basename ${CUBA}))
MINUIT = Minuit2-5.34.14.tar.gz
minuit = $(basename $(basename ${MINUIT}))
QHULL = qhull-2020.2.zip
qhull = $(basename ${QHULL})
HepLib = HepLib.tar.gz
heplib = $(basename $(basename ${HepLib}))
KIRA = kira-2.0
FIRE = fire

.SILENT: help install
help:
	echo "usage: make prefix=<path> jn=32" ;\
	echo "Targets:" ;\
	echo "    install: to install all packages" ; \
	echo "    download: to only download all packages" ;\
	echo "Install only one:" ;\
	echo "    INSTALL_GMP INSTALL_MPFR INSTALL_CLN" ;\
	echo "    INSTALL_GINAC INSTALL_CUBA INSTALL_MINUIT" ;\
	echo "    INSTALL_QHULL INSTALL_HepLib INSTALL_Fermat" ;\
	echo "    INSTALL_FORM INSTALL_FIRE INSTALL_KIRA"

ifndef prefix
    prefix = /usr/local
endif

ifndef jn
    jn = $(shell nproc)
endif

download: ${GMP} ${MPFR} ${CLN} ${GINAC} ${CUBA} ${MINUIT} ${QHULL} ${HepLib} ${KIRA} ${Fermat} ${FIRE} ${FORM}


install: INSTALL_GMP INSTALL_MPFR INSTALL_CLN INSTALL_GINAC INSTALL_CUBA INSTALL_MINUIT INSTALL_QHULL INSTALL_HepLib INSTALL_Fermat INSTALL_FORM INSTALL_FIRE INSTALL_KIRA
	echo "" ;\
	echo "" ;\
	echo "Installation Completed!" ;\
	echo "You can add the following sentences to your .bashrc"  ;\
	echo "" ;\
	echo "export PATH=$prefix/bin:$prefix/FIRE6/bin:\$PATH" ;\
	echo "export LD_LIBRARY_PATH=$prefix/lib:\$LD_LIBRARY_PATH" ;\
	echo ""

INSTALL_KIRA: ${KIRA}
	cp ${KIRA} kira ;\
	chmod +x kira ;\
        mv -f kira ${prefix}/bin/

INSTALL_FIRE: ${FIRE}
	rm -rf ${prefix}/FIRE6 ;\
	cp -rf fire/FIRE6 $prefix/FIRE6 ;\
	cd ${prefix}/FIRE6 ;\
	./configure --enable_zlib --enable_snappy --enable_lthreads --enable_tcmalloc --enable_zstd ;\
	make -j ${jn} dep ;\
	cp extra/lz4-*/lib/*.h usr/include/ ;\
	cp extra/lz4-*/lib/liblz4.a usr/lib/ ;\
	make

INSTALL_FORM: ${FORM}
	tar zxf ${FORM} ;\
	cp -rf ${form}/form ${prefix}/bin/ ;\
	cp -rf ${form}/tform ${prefix}/bin/ ;\
	rm -rf ${form}

INSTALL_Fermat: ${Fermat}
	tar zxf ${Fermat} ;\
	rm -rf ${prefix}/${fermat} ;\
	cp -rf ${fermat} ${prefix}/ ;\
	cd ${prefix}/bin ;\ ;\
	ln -s -f ../${fermat}/fer64 .

INSTALL_HepLib: ${HepLib}
	rm -rf ${heplib} examples ;\
	tar zxfv ${HepLib} ;\
	cd ${heplib} ;\
	mkdir -p build ;\
	cd build ;\
	cmake -DCMAKE_INSTALL_PREFIX=${prefix} .. ;\
	make -j ${jn} ;\
	make install ;\
	rm -rf ${heplib}

INSTALL_QHULL: ${QHULL}
	rm -rf ${qhull} ;\
	unzip ${QHULL} ;\
	cd ${qhull} ;\
	cp Makefile Makefile.bak ;\
	cat Makefile.bak | sed "s/\/usr\/local/\$\$prefix/g" > Makefile ;\
	make ;\
	make install ;\
	rm -rf ${qhull}

INSTALL_MINUIT: ${MINUIT}
	rm -rf ${minuit} ;\
	tar zxfv ${MINUIT} ;\
	cd ${minuit} ;\
	./configure --prefix=${prefix} ;\
	make ;\
	make install ;\
	rm -rf ${minuit}

INSTALL_CUBA: ${CUBA}
	rm -rf ${cuba} ;\
	tar zxfv ${CUBA} ;\
	cd ${cuba} ;\
	./configure --prefix=${prefix} --with-real=16 CFLAGS="-fPIC -fcommon" CXXFLAGS="-fPIC -fcommon" ;\
	make ;\
	make install ;\
	rm -rf ${cuba}

INSTALL_GINAC: INSTALL_GMP ${GINAC}
	rm -rf ${ginac} ;\
	tar jxfv ${GINAC} ;\
	cd ${cln} ;\
	./configure --prefix=${prefix} PKG_CONFIG_PATH=${prefix}/lib/pkgconfig ;\
	make -j ${jn} ;\
	make install ;\
	rm -rf ${ginac}

INSTALL_CLN: INSTALL_GMP ${CLN}
	rm -rf ${cln} ;\
	tar jxfv ${CLN} ;\
	cd ${cln} ;\
	./configure --prefix=${prefix} --with-gmp=${prefix} ;\
	make -j ${jn} ;\
	make install ;\
	rm -rf ${cln}

INSTALL_MPFR: INSTALL_GMP ${MPFR}
	rm -rf ${mpfr} ;\
	tar zxfv ${MPFR} ;\
	cd ${mpfr} ;\
	./configure --prefix=${prefix} --with-gmp=${prefix} --enable-float128 --enable-thread-safe ;\
	make -j ${jn} ;\
	make install ;\
	rm -rf ${mpfr}
	

INSTALL_GMP: ${GMP}
	rm -rf ${gmp} ;\
	tar zxf ${GMP} ;\
	cd ${gmp} ;\
	./configure --prefix=${prefix} ;\
	make -j ${jn} ;\
	make install ;\
	rm -rf ${gmp}

${GMP} :
	wget --no-check-certificate https://gmplib.org/download/gmp/${GMP}

${MPFR}:
	wget --no-check-certificate https://heplib.github.io/download/${MPFR}

${CLN}:
	wget --no-check-certificate https://www.ginac.de/CLN/${CLN}

${GINAC}:
	wget --no-check-certificate https://www.ginac.de/${GINAC}

${CUBA}:
	wget --no-check-certificate http://www.feynarts.de/cuba/${CUBA}

${MINUIT}:
	wget --no-check-certificate http://www.cern.ch/mathlibs/sw/5_34_14/Minuit2/${MINUIT}

${QHULL}:
	wget --no-check-certificate http://www.qhull.org/download/${QHULL}

${HepLib}:
	wget --no-check-certificate https://heplib.github.io/HepLib.tar.gz

${Fermat}:
	wget --no-check-certificate http://home.bway.net/lewis/fermat64/${Fermat}

${FIRE}:
	git clone https://bitbucket.org/feynmanIntegrals/fire.git

${KIRA}:
	wget --no-check-certificate -O ${KIRA} https://kira.hepforge.org/downloads?f=binaries/${KIRA}

${FORM}:
	https://github.com/vermaseren/form/releases/download/v4.2.1/${FORM}










