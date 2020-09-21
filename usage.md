Usage within C++
======
The usage of **HepLib** is similar to other *C++* library by including the proper header files in the *C++* source code, compiling the program and linking with *HepLib* and other necessary libraries. 

Prepare the C++ Code
------
```cpp
#include "HepLib.h"
using namespace HepLib;
using namespace FC;
int main(int argc, char** argv) {
    Index mu("mu"), nu("nu");
    Vector p1("p1"), p2("p2");
    Symbol m("m");
    //note GAS(1) in gline, corresponds to the identity matrix
    ex gline = GAS(p1)*GAS(mu)*(GAS(p2)+m*GAS(1))*GAS(mu);
    ex trace = form(TR(gline));
    cout << trace << endl;
    return 0;
}
```
The above code [trace.cpp](download/trace.cpp) shows how to perform the D-dimensional trace on a Dirac-&#x1D6FE; chain: 
[gimmick: math]()
$$ {\rm Tr}[\gamma^\mu \gamma_\mu] $$

$$ 
{\rm Tr}[ p_1 \gamma^\mu (p_2 + m) \gamma_\mu ] 
$$

Compile and Run
------
One can compile the [trace.cpp](download/trace.cpp) using **heplib++** and run it as follows:
```bash
$ <INSTALL PATH>/bin/heplib++ -o trace trace.cpp 
$ ./trace
-4*D*p2.p1+8*p2.p1
```

One can also compile the program with **pkg-config** as follows, 
```bash
export PKG_CONFIG_PATH=<INSTALL PATH>/lib/pkgconfig:$PKG_CONFIG_PATH
g++ $(pkg-config --cflags --libs HepLib) -o trace trace.cpp
```

Furthermore, one can provide the g++ flags and libraries explicitly as follows:
```bash
g++ -I <INSTALL PATH>/include -L <INSTALL PATH>/lib -Wl,-rapth,<INSTALL PATH>/lib -lHepLib -lginac -o trace trace.cpp
```



