#include "HepLib.h"

using namespace HepLib;
using namespace SD;

int main(int argc, char** argv) {
    
    auto iep = iEpsilon;
    auto t = vs;
            
    XIntegrand xint;
    
    xint.Function = lst{x(1), x(1)+t*x(2), 1+t, 1-2*t};
    xint.Exponent = lst{0, -3+ep, -3, 3};
    
    SecDec work;
    work.eps_lst = lst{ lst{ep, 2} };
    work.vsN = 3;
    Verbose = 12;
    
    work.Evaluate(xint);

    work.VEPrint();
            
    return 0;
}
