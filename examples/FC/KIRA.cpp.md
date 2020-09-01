[Download](KIRA.cpp)
```cpp
#include "IBP.h"

using namespace HepLib;
using namespace IBP;

int main(int argc, char** argv) {

    Symbol k1("k1"), k2("k2");
    Symbol p("p"), n("n");
    Symbol m("m"), eps("eps");
    
    ex z = ex(3)/4;
    ex m2 = 1;
    ex kp = 1;
    lst prop;
        
    prop.append(power(k1,2));
    prop.append(power(k2,2));
    prop.append(n*(k1+k2+2*p)-kp);
    
    prop.append(power(k1+k2, 2));
    prop.append(power(k1+k2+2*p, 2));
    prop.append(power(k2+2*p, 2));
    prop.append(n*k2);
    prop.append(n*k1);
    
    lst repl = { p*p == m2, n*n==0, n*p==z/2 };
    lst loop = { k1, k2 };
    lst ext = { p, n };
    
    KIRA ibp;
    ibp.Internal = loop;
    ibp.External = ext;
    ibp.Propagators = prop;
    ibp.Replacements = repl;
    ibp.Cuts = lst{1,2,3};
    ibp.Integrals = lst{ lst{1, 1, 1, 0, 2, 1, 1, 0} };
    
    ibp.Shift[8-1] = eps;
    ibp.Shift[7-1] = eps;
    ibp.WorkingDir = "ibp";
    ibp.Reduce();
    system("rm -rf ibp");
    
    cout << ibp.Rules << endl;
    cout << ibp.MasterIntegrals << endl;
    
    return 0;
}
```
