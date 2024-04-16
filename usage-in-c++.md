# Usage in C++

The usage of **HepLib** is similar to other _C++_ library by including the proper header files in the _C++_ source code, compiling the program and linking with **HepLib** and other necessary libraries.

## 1. Prepare the C++ Code

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
    hout << trace << endl;
    return 0;
}
```

The above code `trace.cpp` shows how to perform the D-dimensional trace on a Dirac-𝛾 chain:

$$
{\rm Tr} \left[\gamma.p_1 \gamma^\mu (\gamma.p_2 + m) \gamma_\mu \right]
$$

## 2. Compile and Run

* One can compile the `trace.cpp` using `heplib++` and run it as follows:

```bash
<INSTALL PATH>/bin/heplib++ -o trace trace.cpp
./trace
# 8*p2.p1+(-4)*D*p2.p1
```

