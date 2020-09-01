Install HepLib
------
* Using the [install.sh](install.sh) script

```bash
wget https://heplib.github.io/install.sh 
chmod +x install.sh
prefix=<Install Path> jn=16 ./install.sh
```
* Install external libraries:
    + **GiNaC**: the underlying language of **HepLib**, which is used for symbolic operations and can be download from [https://www.ginac.de](https://www.ginac.de), and its prerequisite **CLN** can be download from [https://www.ginac.de/CLN/](https://www.ginac.de/CLN/).
    + **Qgraf**: the version 3.1.4 has been included in **HepLib**, which can be download form [http://cfif.ist.utl.pt/~paulo/qgraf.html](http://cfif.ist.utl.pt/~paulo/qgraf.html).
    + **QHull**: it is used for sector decompostion with geometric stratage and available on[http://www.qhull.org](http://www.qhull.org).
    + **MinUit2**: it is used to find the minimum of a function, avaiable on [http://seal.web.cern.ch/seal/snapshot/work-packages/mathlibs/minuit/](http://seal.web.cern.ch/seal/snapshot/work-packages/mathlibs/minuit/).
    + **CUBA**: it is one of the numerical integrators and can be download from [http://www.feynarts.de/cuba/](http://www.feynarts.de/cuba/), note that the version with quadruple precision **libcubaq** will be used, by adding the option `--with--real=16 CFLAGS="--fPIC" CXXFLAGS="--fPIC"` to the `configure` script.
    

