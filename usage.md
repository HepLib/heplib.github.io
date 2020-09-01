
Usage within C++
------
The usage of **HepLib** is similar to other `C++` library by including the proper header files in the `C++` source code, compiling the program and linking with HepLib and other necessary libraries. 

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

The above code [hello.cpp](examples/hello.cpp) shows how to perform the D-dimensional trace on a Dirac-γ chain:

![](img/tr.png) 

Assuming the `<HepLib Install Path>/bin` is added to the environment variable `PATH` , if not please run 
```bash
export PATH=<HepLib Install Path>/bin:$PATH
```
 `<HepLib Install Path>/lib` is added to the environment variable `LD_LIBRARY_PATH`, if not please run 
 ```bash
 export LD_LIBRARY_PATH=<HepLib Install Path>/lib:$LD_LIBRARY_PATH
 ```
 We can compile the [hello.cpp](examples/hello.cpp.md) and run it like this:
```bash
$ heplib++ -o hello hello.cpp 
$ ./ hello
-4*D*p2.p1+8*p2.p1
```





