#include "HepLib.h"

using namespace HepLib;
using namespace SD;

int main(int argc, char** argv) {

    Verbose = 100;
    
    { // case 1
        XIntegrand xint;
        xint.Function = lst{ 1, x(2)*x(4)*x(4)-x(1)*x(3)*x(3) };
        xint.Exponent = lst{ 1, -1+ep };
        xint.Deltas = lst{ xlst(1,4) }; // xlst(1,4) = {x(1),x(2),x(3),x(4)}
        
        SecDec work;
        work.eps_lst = lst{ lst{ep, 2} };
                
        auto hc = new HCubature();
        hc->QXLimit = 1E-2;
        hc->MPXLimit = 1E-4;
        work.Integrator = hc;
        
        work.Evaluate(xint);
        work.VEPrint();
        
        cout << WHITE << "Check with: " << RESET << endl;
        cout << "I*2.4674011003(0)*ep^(-1) + (I*(-4.587862898(7))+3.875785(5)) + (I*(-4.214817(4))+(-7.20660(1)))*ep + (I*2.613491(2)E1+(-3.43291(3)))*ep^2" << endl;
    }
    
    { // case 2
        XIntegrand xint;
        xint.Function = lst{ 1, pow(x(2),2)-x(1)*x(3) };
        xint.Exponent = lst{ 1, -1+ep };
        xint.Deltas = lst{xlst(1,3)};
        
        SecDec work;
        work.eps_lst = lst{ lst{ep, 2} };
                        
        auto hc = new HCubature();
        hc->QXLimit = 1E-2;
        hc->MPXLimit = 1E-4;
        work.Integrator = hc;
        
        work.Evaluate(xint);
        work.VEPrint();
        
        cout << WHITE << "Check with: " << RESET << endl;
        cout << "((-1.171953619(4))+I*3.7988125052(0)) + (I*(-6.627956021(9))+1.1301038(9)E1)*ep + ((-2.429478(3)E1)+I*2.71830(3)E-1)*ep^2" << endl;
    }
    
    { // case 3
        XIntegrand xint;
        xint.Function = lst{ x(1), x(2)*x(2)-x(0)*x(1) };
        xint.Exponent = lst{ -1+ep, -1+ep };
        xint.Deltas = lst{lst{x(0),x(1),x(2)}};
        
        SecDec work;
        work.eps_lst = lst{ lst{ep, 2} };
        
        auto hc = new HCubature();
        hc->QXLimit = 1E-2;
        hc->MPXLimit = 1E-4;
        work.Integrator = hc;
        
        work.Evaluate(xint);
        work.VEPrint();
        
        cout << WHITE << "Check with: " << RESET << endl;
        cout << "(-7.5000000000(0)E-1)*ep^(-1) + (I*(-2.3561944902(0))+(-3.000000000(4))) + (I*(-2.6519434234(9)E1)+(-7.959910(6)))*ep + (I*(-3.47987790(4)E1)+(-9.122095(1)E1))*ep^2" << endl;
    }    
     
    
    return 0;
}
