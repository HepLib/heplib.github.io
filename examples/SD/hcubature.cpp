#include "HepLib.h"

using namespace HepLib;
using namespace SD;

int main(int argc, char** argv) {
    
    symbol k("k"), r("r"), q("q"), q1("q1"), q2("q2");
    symbol p1("p1"), p2("p2"), p3("p3"), p4("p4"), p5("p5");
    symbol m("m"), s("s"), t("t"), u("u");

    ex m2=m*m;
    FeynmanParameter fp;

    fp.LoopMomenta = lst {k};
    fp.Propagators = lst{ -pow(k,2),-pow(k + p1,2),-pow(k + p1 + p2,2),-pow(k + p1 + p2 + p4,2) };
    fp.Exponents = lst{ 1, 1, 1, 1 };
    fp.lReplacements[p1*p1] = 0;
    fp.lReplacements[p2*p2] = 0;
    fp.lReplacements[p4*p4] = 0;
    fp.lReplacements[p1*p2] = -s/2;
    fp.lReplacements[p2*p4] = -t/2;
    fp.lReplacements[p1*p4] = (s+t)/2;
    fp.lReplacements[s] = -3;
    fp.lReplacements[t] = 1;
    fp.Prefactor = pow(I*pow(Pi,2-ep)*exp(-ep*Euler), -1);

    SecDec work;
    work.epN = 0;
    Verbose = 100;
    
    auto hcubature = new HCubature();
    work.Integrator = hcubature;
    work.TryPTS = 1000000;
    work.RunPTS = 1000000;
    work.RunMAX = 10;

    work.Evaluate(fp);

    cout << work.VEResult() << endl;
    cout << "check with:" << endl;
    cout << "4.38649084(1)+(I*(-2.0943951024(0))+7.3240819245(0)E-1)*ep^(-1)+(-1.3333333333(0))*ep^(-2)" << endl;

    return 0;
}
