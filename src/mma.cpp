#include "HepLib.h"

using namespace std;
using namespace GiNaC;
using namespace HepLib;


int main() {

    Symbol a("a"), b("b"), m("m"), s("s"); 

    ex num = pow(a+b,4) * pow(a*b+s+m,4);
    ex den = (a+b+s)*(a+s*b);
    ex nd = num / den;

    cout << num << endl;
    auto ex_num = num.expand();
    cout << "collect w.r.t. {a,b}:" << endl;
    cout << mma_collect(ex_num, lst{a,b}, true, true) << endl;
    cout << "check: 0 = " << normal(num-ex_num.subs(lst{coCF(w)==w,coVF(w)==w})) << endl;
    cout << endl;
    
    cout << nd << endl;
    auto ex_s3 = mma_series(nd,s,3);
    cout << "series up to O(s^3):" << endl;
    cout << ex_s3 << endl;
    cout << endl;

}

