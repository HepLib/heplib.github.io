all : install

UNAMES := $(shell uname -s)
ifeq ($(UNAMES),Linux)
    Fermat = ferl6.tar.gz
    fermat = $(basename $(basename ${Fermat}))
    FORM = form-4.2.1-x86_64-linux.tar.gz
    form = $(basename $(basename ${FORM}))
endif
ifeq ($(UNAMES),Darwin)
    Fermat = ferm6.tar.gz
    fermat = $(basename $(basename ${Fermat}))
    FORM = form-4.2.1-x86_64-osx.tar.gz
    form = $(basename $(basename ${FORM}))
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

CWD=$(shell pwd)

.SILENT:

help:
	echo "usage: make prefix=<path> jn=32" ;\
	echo "Targets:" ;\
	echo "    install: to install all packages" ;\
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


install: INSTALL_GMP INSTALL_MPFR INSTALL_CLN INSTALL_GINAC INSTALL_CUBA INSTALL_MINUIT INSTALL_QHULL INSTALL_Fermat INSTALL_FORM INSTALL_FIRE INSTALL_KIRA INSTALL_HepLib
	echo "" ;\
	echo "" ;\
	echo "Installation Completed!" ;\
	echo "You can add the following sentences to your .bashrc"  ;\
	echo "" ;\
	echo "export PATH=${prefix}/bin:${prefix}/FIRE6/bin:\$PATH" ;\
	echo "export LD_LIBRARY_PATH=${prefix}/lib:\$LD_LIBRARY_PATH" ;\
	echo ""

INSTALL_KIRA: ${KIRA}
	echo "Installing KIRA ..."
	cp ${KIRA} kira ;\
	chmod +x kira ;\
        mv -f kira ${prefix}/bin/ ;\
	echo ""

INSTALL_FIRE: ${FIRE}
	echo "Installing FIRE ..."
	rm -rf ${prefix}/FIRE6 ;\
	cp -rf fire/FIRE6 ${prefix}/ ;\
	cd ${prefix}/FIRE6 ;\
	./configure --enable_zlib --enable_snappy --enable_lthreads --enable_tcmalloc --enable_zstd 2>${CWD}/log.txt >${CWD}/log.txt;\
	make -j ${jn} dep >> ${CWD}/log.txt ;\
	make >> ${CWD}/log.txt ;\
	echo ""

INSTALL_FORM: ${FORM}
	echo "Installing FORM ..."
	rm -rf ${form}
	tar zxf ${FORM} ;\
	cp -rf ${form}/form ${prefix}/bin/ ;\
	cp -rf ${form}/tform ${prefix}/bin/ ;\
	cd ${CWD} ;\
	rm -rf ${form} ;\
	echo ""

INSTALL_Fermat: ${Fermat}
	echo "Installing Fermat ..."
	rm -rf ${fermat} ;\
	tar zxf ${Fermat} ;\
	rm -rf ${prefix}/${fermat} ;\
	mv ${fermat} ${prefix}/ ;\
	cd ${prefix}/bin ;\
	ln -s -f ../${fermat}/fer64 . ;\
	echo ""

INSTALL_HepLib: ${HepLib}
	echo "Installing HepLib ..."
	rm -rf ${heplib} examples ;\
	tar zxf ${HepLib} ;\
	cd ${heplib} ;\
	mkdir -p build ;\
	cd build ;\
	cmake -DCMAKE_INSTALL_PREFIX=${prefix} .. ;\
	make -j ${jn} ;\
	make install ;\
	cd ${CWD} ;\
	rm -rf ${heplib} ;\
	echo ""

INSTALL_QHULL: ${QHULL}
	echo "Installing QHull ..."
	rm -rf ${qhull} ;\
	unzip -q ${QHULL} ;\
	cd ${qhull} ;\
	cp Makefile Makefile.bak ;\
	cat Makefile.bak | sed "s/\/usr\/local/$(subst /,\/,${prefix})/g" > Makefile ;\
	make >> ${CWD}/log.txt ;\
	make install >> ${CWD}/log.txt ;\
	cd ${CWD} ;\
	rm -rf ${qhull} ;\
	echo ""

INSTALL_MINUIT: ${MINUIT}
	echo "Installing MinUit2 ..."
	rm -rf ${minuit} ;\
	tar zxf ${MINUIT} ;\
	cd ${minuit} ;\
	./configure --prefix=${prefix} >> ${CWD}/log.txt ;\
	make -j ${jn} >> ${CWD}/log.txt ;\
	make install >> ${CWD}/log.txt ;\
	cd ${CWD} ;\
	rm -rf ${minuit} ;\
	echo ""

INSTALL_CUBA: ${CUBA}
	echo "Installing CUBA ..."
	rm -rf ${cuba} ;\
	tar zxf ${CUBA} ;\
	cd ${cuba} ;\
	./configure --prefix=${prefix} --with-real=16 CFLAGS="-fPIC -fcommon" CXXFLAGS="-fPIC -fcommon" >> ${CWD}/log.txt ;\
	make >> ${CWD}/log.txt ;\
	make install >> ${CWD}/log.txt ;\
	cd ${CWD} ;\
	rm -rf ${cuba} ;\
	echo ""

INSTALL_GINAC: ${GINAC}
	echo "Installing GiNaC ..."
	rm -rf ${ginac} ;\
	tar jxf ${GINAC} ;\
	cd ${ginac} ;\
	./configure --prefix=${prefix} PKG_CONFIG_PATH=${prefix}/lib/pkgconfig >> ${CWD}/log.txt ;\
	make -j ${jn} >> ${CWD}/log.txt ;\
	make install >> ${CWD}/log.txt ;\
	cd ${CWD}
	rm -rf ${ginac} ;\
	echo ""

INSTALL_CLN: ${CLN}
	echo "Installing CLN ..."
	rm -rf ${cln} ;\
	tar jxf ${CLN} ;\
	cd ${cln} ;\
	./configure --prefix=${prefix} --with-gmp=${prefix} >> ${CWD}/log.txt ;\
	make -j ${jn} >> ${CWD}/log.txt ;\
	make install >> ${CWD}/log.txt ;\
	cd ${CWD} ;\
	rm -rf ${cln} ;\
	echo ""

INSTALL_MPFR: ${MPFR}
	echo "Installing MPFR ..."
	rm -rf ${mpfr} ;\
	tar zxf ${MPFR} ;\
	cd ${mpfr} ;\
	./configure --prefix=${prefix} --with-gmp=${prefix} --enable-float128 --enable-thread-safe >> ${CWD}/log.txt ;\
	make -j ${jn} >> ${CWD}/log.txt ;\
	make install >> ${CWD}/log.txt ;\
	cd ${CWD} ;\
	rm -rf ${mpfr} ;\
	echo ""
	
INSTALL_GMP: ${GMP}
	echo "Installing GMP ..."
	rm -rf ${gmp} ;\
	tar zxf ${GMP} ;\
	cd ${gmp} ;\
	./configure --prefix=${prefix} >> ${CWD}/log.txt ;\
	make -j ${jn} >> ${CWD}/log.txt ;\
	make install >> ${CWD}/log.txt ;\
	cd ${CWD} ;\
	rm -rf ${gmp} ;\
	echo ""

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
	wget https://github.com/vermaseren/form/releases/download/v4.2.1/${FORM}

