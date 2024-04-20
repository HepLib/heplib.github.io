### **How** to Install `HepLib`
- Download and extract the `all-in-one` archive
```bash
wget https://heplib.github.io/download/Install.tar.gz
tar xfv Install.tar.gz
```

- Install using `install.sh`
```bash
cd Install
INSTALL_PATH=<Path to Install> jn=8 ./install.sh
# INSTALL_PATH=<Path to Install> jn=8 ./install-M1.sh # Apple Silicon Chip
```

### **Try** a simple example
1. Prepare a `C++` file named `trace.cpp` with the following content
```cpp
#include "HepLib.h"
using namespace HepLib;
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

2. Compile `trace.cpp` using `heplib++` from `HepLib`
```bash
INSTALL_PATH/bin/heplib++ -o trace trace.cpp
```

3. Run `trace` to get the trace for $${\rm Tr}[\gamma\cdot p_1 \ \gamma^\mu\ (\gamma\cdot p_2+m)\ \gamma_\mu]$$
```bash
./trace
# -4*d*p2.p1+8*p2.p1
```
