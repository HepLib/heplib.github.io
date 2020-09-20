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
LOG=${CWD}/log.txt

.SILENT:

help:
	echo "usage: make INSTALL_PATH=<path> jn=32" ;\
	echo "Targets:" ;\
	echo "    install: to install all packages" ;\
	echo "    download: to only download all packages" ;\
	echo "Install only one:" ;\
	echo "    INSTALL_GMP INSTALL_MPFR INSTALL_CLN" ;\
	echo "    INSTALL_GINAC INSTALL_CUBA INSTALL_MINUIT" ;\
	echo "    INSTALL_QHULL INSTALL_HepLib INSTALL_Fermat" ;\
	echo "    INSTALL_FORM INSTALL_FIRE INSTALL_KIRA"

ifndef INSTALL_PATH
    INSTALL_PATH = /usr/local/HepLib
endif

ifndef jn
    jn = 8
endif

download: ${GMP} ${MPFR} ${CLN} ${GINAC} ${CUBA} ${MINUIT} ${QHULL} ${HepLib} ${KIRA} ${Fermat} ${FIRE} ${FORM}


install: INSTALL_GMP INSTALL_MPFR INSTALL_CLN INSTALL_GINAC INSTALL_CUBA INSTALL_MINUIT INSTALL_QHULL INSTALL_Fermat INSTALL_FORM INSTALL_FIRE INSTALL_KIRA INSTALL_HepLib
	echo "" ;\
	echo "Installation Completed!" ;\
	echo ""

INSTALL_KIRA: ${KIRA}
	echo "Installing KIRA ..." ;\
	cp ${KIRA} kira ;\
	chmod +x kira ;\
        mv -f kira ${INSTALL_PATH}/bin/ ;\
	echo ""

INSTALL_FIRE: ${FIRE}
	echo "Installing FIRE ..." ;\
	export CC=gcc ;\
	export CXX=g++ ;\
	rm -rf ${INSTALL_PATH}/FIRE6 ;\
	cp -rf fire/FIRE6 ${INSTALL_PATH}/ ;\
	cd ${INSTALL_PATH}/FIRE6 ;\
	./configure --enable_zlib --enable_snappy --enable_lthreads --enable_tcmalloc --enable_zstd >>${LOG} 2>>${LOG} ;\
	make -j ${jn} dep >>${LOG} 2>>${LOG} ;\
	mkdir -p usr/include ;\
	cp -f extra/lz4-*/lib/*.h usr/include/ ;\
	cp -f extra/lz4-*/lib/liblz4.a usr/lib/ ;\
	make >>${LOG} 2>>${LOG} ;\
	echo ""

INSTALL_FORM: ${FORM}
	echo "Installing FORM ..." ;\
	rm -rf ${form} ;\
	tar zxf ${FORM} ;\
	cp -rf ${form}/form ${INSTALL_PATH}/bin/ ;\
	cp -rf ${form}/tform ${INSTALL_PATH}/bin/ ;\
	cd ${CWD} ;\
	rm -rf ${form} ;\
	echo ""

INSTALL_Fermat: ${Fermat}
	echo "Installing Fermat ..." ;\
	rm -rf ${fermat} ;\
	tar zxf ${Fermat} ;\
	rm -rf ${INSTALL_PATH}/${fermat} ;\
	mv ${fermat} ${INSTALL_PATH}/ ;\
	cd ${INSTALL_PATH}/bin ;\
	ln -s -f ../${fermat}/fer64 . ;\
	echo ""

INSTALL_HepLib: ${HepLib}
	echo "Installing HepLib ..." ;\
	rm -rf ${heplib} ;\
	tar zxf ${HepLib} ;\
	cd ${heplib}/src ;\
	mkdir -p build ;\
	cd build ;\
	cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} .. ;\
	make -j ${jn} ;\
	make install ;\
	cd ${CWD} ;\
	echo ""

INSTALL_QHULL: ${QHULL}
	echo "Installing QHull ..." ;\
	rm -rf ${qhull} ;\
	unzip -q ${QHULL} ;\
	cd ${qhull} ;\
	cp Makefile Makefile.bak ;\
	cat Makefile.bak | sed "s/\/usr\/local/$(subst /,\/,${INSTALL_PATH})/g" > Makefile ;\
	make >>${LOG} 2>>${LOG} ;\
	make install >>${LOG} 2>>${LOG} ;\
	cd ${CWD} ;\
	rm -rf ${qhull} ;\
	echo ""

INSTALL_MINUIT: ${MINUIT}
	echo "Installing MinUit2 ..." ;\
	rm -rf ${minuit} ;\
	tar zxf ${MINUIT} ;\
	cd ${minuit} ;\
	./configure --prefix=${INSTALL_PATH} >>${LOG} 2>>${LOG} ;\
	make -j ${jn} >>${LOG} 2>>${LOG} ;\
	make install >>${LOG} 2>>${LOG} ;\
	cd ${CWD} ;\
	rm -rf ${minuit} ;\
	echo ""

INSTALL_CUBA: ${CUBA}
	echo "Installing CUBA ..." ;\
	rm -rf ${cuba} ;\
	tar zxf ${CUBA} ;\
	cd ${cuba} ;\
	./configure --prefix=${INSTALL_PATH} --with-real=16 CFLAGS="-fPIC -fcommon" CXXFLAGS="-fPIC -fcommon" >>${LOG} 2>>${LOG} ;\
	make >>${LOG} 2>>${LOG} ;\
	make install >>${LOG} 2>>${LOG} ;\
	cd ${CWD} ;\
	rm -rf ${cuba} ;\
	echo ""

INSTALL_GINAC: ${GINAC}
	echo "Installing GiNaC ..." ;\
	rm -rf ${ginac} ;\
	tar jxf ${GINAC} ;\
	cd ${ginac} ;\
	./configure --prefix=${INSTALL_PATH} PKG_CONFIG_PATH=${INSTALL_PATH}/lib/pkgconfig >>${LOG} 2>>${LOG} ;\
	make -j ${jn} >>${LOG} 2>>${LOG} ;\
	make install >>${LOG} 2>>${LOG} ;\
	cd ${CWD}
	rm -rf ${ginac} ;\
	echo ""

INSTALL_CLN: ${CLN}
	echo "Installing CLN ..." ;\
	rm -rf ${cln} ;\
	tar jxf ${CLN} ;\
	cd ${cln} ;\
	./configure --prefix=${INSTALL_PATH} --with-gmp=${INSTALL_PATH} >>${LOG} 2>>${LOG} ;\
	make -j ${jn} >>${LOG} 2>>${LOG} ;\
	make install >>${LOG} 2>>${LOG} ;\
	cd ${CWD} ;\
	rm -rf ${cln} ;\
	echo ""

INSTALL_MPFR: ${MPFR}
	echo "Installing MPFR ..." ;\
	rm -rf ${mpfr} ;\
	tar zxf ${MPFR} ;\
	cd ${mpfr} ;\
	./configure --prefix=${INSTALL_PATH} --with-gmp=${INSTALL_PATH} --enable-float128 --enable-thread-safe >>${LOG} 2>>${LOG} ;\
	make -j ${jn} >>${LOG} 2>>${LOG} ;\
	make install >>${LOG} 2>>${LOG} ;\
	cd ${CWD} ;\
	rm -rf ${mpfr} ;\
	echo ""
	
INSTALL_GMP: ${GMP}
	echo "Installing GMP ..." ;\
	rm -rf ${gmp} ;\
	tar zxf ${GMP} ;\
	cd ${gmp} ;\
	./configure --prefix=${INSTALL_PATH} >>${LOG} 2>>${LOG} ;\
	make -j ${jn} >>${LOG} 2>>${LOG} ;\
	make install >>${LOG} 2>>${LOG} ;\
	cd ${CWD} ;\
	rm -rf ${gmp} ;\
	echo ""

${GMP} :
	curl -L -O https://gmplib.org/download/gmp/${GMP}

${MPFR}:
	curl -L -O https://heplib.github.io/download/${MPFR}

${CLN}:
	curl -L -O https://www.ginac.de/CLN/${CLN}

${GINAC}:
	curl -L -O https://www.ginac.de/${GINAC}

${CUBA}:
	curl -L -O http://www.feynarts.de/cuba/${CUBA}

${MINUIT}:
	curl -L -O http://project-mathlibs.web.cern.ch/project-mathlibs/sw/5_34_14/Minuit2/${MINUIT}

${QHULL}:
	curl -L -O http://www.qhull.org/download/${QHULL}

${HepLib}:
	curl -L -O https://heplib.github.io/HepLib.tar.gz

${Fermat}:
	curl -L -O http://home.bway.net/lewis/fermat64/${Fermat}

${FIRE}:
	git clone https://bitbucket.org/feynmanIntegrals/fire.git

${KIRA}:
	curl -L -o ${KIRA} https://kira.hepforge.org/downloads?f=binaries/${KIRA}

${FORM}:
	curl -L -O https://github.com/vermaseren/form/releases/download/v4.2.1/${FORM}

