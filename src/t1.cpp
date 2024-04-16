#include "HepLib.h"

using namespace HepLib;
using namespace SD;

int main(int argc, char** argv) {
    
    auto ep = SD::ep;
    auto iep = SD::iEpsilon;
    
    symbol k("k"), l("l"), r("r"), q("q"), q1("q1"), q2("q2");
    symbol p1("p1"), p2("p2"), p3("p3"), p4("p4"), p5("p5");
    symbol m("m"), s("s"), t("t"), u("u");
    
    ex m2=m*m;
    FeynmanParameter fp;

    fp.LoopMomenta = lst {k, r, q};
    fp.Propagators = lst{ -pow(k,2),-pow(k + p1 + p2,2),-pow(-k + r,2),-pow(p1 + r,2),-pow(k - q,2),-pow(p1 + q,2) };
    fp.Exponents = lst{ 1,1,1,1,1,1 };
    fp.lReplacements[p1*p1] = 0;
    fp.lReplacements[p2*p2] = 0;
    fp.lReplacements[p2*p1] = s/2;
    fp.lReplacements[s] = 1;
    fp.Prefactor = pow(I*pow(Pi,2-ep), -3) * pow(tgamma(1-ep), 3);

    SecDec work;
    work.epN = 0;
    Verbose = 2;
    
    work.Evaluate(fp);

    cout << work.VEResult() << endl;
    cout << "check with:" << endl;
    cout << "ep^(-3)*3.333333333(8)E-1+(I*3.141592654(7)+2.6666667(1))*ep^(-2)+(I*2.5132741(1)E1+3.152128(4))*ep^(-1)+I*1.2272693(4)E2+(-2.919394(6)E1)" << endl;
    
    return 0;
}
