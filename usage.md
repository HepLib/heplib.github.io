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
The above code [hello.cpp](examples/hello.cpp) shows how to perform the D-dimensional trace on a Dirac-&#x1D6FE; chain:

![](img/tr.png) 


Compile and Run
------
One can compile the [hello.cpp](examples/hello.cpp) and run it like this:
```bash
$ <INSTALL PATH>/bin/heplib++ -o hello hello.cpp 
$ ./ hello
-4*D*p2.p1+8*p2.p1
```

One can also compile the program with **pkg-config** as follows, 
```bash
export PKG_CONFIG_PATH=<INSTALL PATH>/lib/pkgconfig:$PKG_CONFIG_PATH
g++ $(pkg-config --cflags --libs HepLib) -o hello hello.cpp
```

Furthermore, one can provide the g++ flags and libraries explicitly as follows:
```bash
g++ -I <INSTALL PATH>/include -L <INSTALL PATH>/lib -Wl,-rapth,<INSTALL PATH>/lib -lHepLib -lginac -o hello hello.cpp
```



