#include "SD.h"
#include "mpreal.h"

using namespace HepLib;
using namespace SD;

int main(int argc, char** argv) {

    Verbose = 100;
    
    { // with delta
        XIntegrand xint;
        xint.Function = lst{ 1, pow(x(1)-2*x(2),2)};
        xint.Exponent = lst{ 1, -1+ep };
        xint.Deltas = lst{lst{x(1),x(2)}};
        SecDec work;
        work.eps_lst = lst{ lst{ep, 3} };
        work.Evaluate(xint);
        cout << work.VEResult() << endl;
        cout << "check with:" << endl;
        cout << "(-2.6222491250(6))*ep^2+(-5.31850373(3))*ep^3+(-5.0000000000(0)E-1)+(-1.2310490602(0))*ep" << endl << endl;
    }
    
    { // with delta
        XIntegrand xint;
        xint.Function = lst{ 1, pow(x(1)-x(2)+x(3),2)};
        xint.Exponent = lst{ 1, -1+ep };
        xint.Deltas = lst{ lst{x(1),x(2),x(3)} };
        SecDec work;
        work.eps_lst = lst{ lst{ep, 1} };
        work.Evaluate(xint);
        cout << work.VEResult() << endl;
        cout << "check with:" << endl;
        cout << "ep*(-1.00000000(6))+(-5.000000000(1)E-1)" << endl << endl;
    }

    { // without delta
        XIntegrand xint;
        xint.Function = lst{ 1, pow(x(1)+x(2)-1,2), x(2)};
        xint.Exponent = lst{ 1, -1+ep, 2+ep};
        SecDec work;
        work.eps_lst = lst{ lst{ep, 3} };
        work.CheckEnd = true;
        work.Evaluate(xint);
        cout << work.VEResult() << endl;
        cout << "check with:" << endl;
        cout << "(-9.85405(1))*ep^3+(-5.0000000000(0)E-1)*ep^(-1)+2.4889(1)E-1*ep^2+ep*(-2.3550659(8))" << endl << endl;
    }
    
    { // without delta
        XIntegrand xint;
        xint.Function = lst{ 1, x(1)-x(2)};
        xint.Exponent = lst{ 1, -1+ep};
        SecDec work;
        work.eps_lst = lst{ lst{ep, 3} };
        work.CheckEnd = true;
        work.Evaluate(xint);
        cout << work.VEResult() << endl;
        cout << "check with:" << endl;
        cout << "(I*(-2.02612013(5))+(-4.934802201(3)))*ep^2+0(2)E-26+(I*2.0261201(5)+8.7609007(8)E-1)*ep^3+I*3.1415926536(0)+ep*(I*(-3.141592654(2))+4.9348022005(0))" << endl << endl;
    }
    
    { // without delta
        XIntegrand xint;
        xint.Function = lst{ 1, 1-2*x(2)};
        xint.Exponent = lst{ 1, -1+ep};
        SecDec work;
        work.eps_lst = lst{ lst{ep, 3} };
        work.Evaluate(xint);
        cout << work.VEResult() << endl;
        cout << "check with:" << endl;
        cout << "ep^3*(-2.0293560632(0))+ep*2.4674011003(0)+I*1.5707963268(0)+I*(-2.5838563900(0))*ep^2" << endl << endl;
    }
    
    { // without delta
        XIntegrand xint;
        xint.Function = lst{ 1, 1-2*x(2)};
        xint.Exponent = lst{ 1, -1+ep};
        SecDec work;
        work.eps_lst = lst{ lst{ep, 3} };
        work.Evaluate(xint);
        cout << work.VEResult() << endl;
        cout << "check with:" << endl;
        cout << "ep^3*(-2.0293560632(0))+ep*2.4674011003(0)+I*1.5707963268(0)+I*(-2.5838563900(0))*ep^2" << endl << endl;
    }
    
    
    { // without delta
        XIntegrand xint;
        xint.Function = lst{ 1, pow(1-2*x(2),4)};
        xint.Exponent = lst{ 1, (-1+ep)};
        SecDec work;
        work.eps_lst = lst{ lst{ep, 3} };
        work.Evaluate(xint);
        cout << work.VEResult() << endl;
        cout << "check with:" << endl;
        cout << "(-5.9259259259(0)E-1)*ep^2+(-3.3333333333(0)E-1)+(-4.4444444444(0)E-1)*ep+(-7.9012345679(0)E-1)*ep^3" << endl << endl;
    }
    
    return 0;
}
