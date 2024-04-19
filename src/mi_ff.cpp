#include "HepLib.h"

using namespace HepLib;
using namespace SD;

int main(int argc, char** argv) {
        
    Symbol p("p"), n("n");
    Symbol k1("k1"), k2("k2"), k3("k3");
    Symbol K1("K1"), K2("K2"), K3("K3");
    Symbol kp("kp");
    Symbol m("m"), zz("zz");
    
    ex m2=m*m;
    ex z0 = ex(1)/4;
    
    ex k1p = z(1)*(1-zz)*kp;
    ex k1m = pow(K1,2)/(2*k1p);
    ex k2p = z(2)*(1-zz)*kp;
    ex k2m = pow(K2,2)/(2*k2p);
    ex k3p = z(3)*(1-zz)*kp;
    ex k3m = pow(K3,2)/(2*k3p);
    
    ex pp = zz/2*kp;
    ex pm = m2/(2*pp);
    
    FeynmanParameter fp;
    
    fp.LoopMomenta = lst{};
    fp.tLoopMomenta = lst{K1,K2};
    fp.Propagator = lst {
        k1*k2 + k1*p + k2*p
    };

    fp.Exponent = lst{ 1 };
    fp.lReplacement[p*p] = m2;
    fp.lReplacement[n*n] = 0;
    fp.lReplacement[n*p] = pp;
    fp.lReplacement[k1*k1] = 0;
    fp.lReplacement[k2*k2] = 0;
    fp.lReplacement[k3*k3] = 0;
    fp.lReplacement[n*k1] = k1p;
    fp.lReplacement[n*k2] = k2p;
    fp.lReplacement[n*k3] = k3p;
    fp.lReplacement[p*k1] = k1p*pm+k1m*pp;
    fp.lReplacement[p*k2] = k2p*pm+k2m*pp;
    fp.lReplacement[p*k3] = k3p*pm+k3m*pp;
    fp.lReplacement[k1*k2] = k1p*k2m+k2p*k1m-K1*K2;
    fp.lReplacement[k2*k3] = k2p*k3m+k3p*k2m-K2*K3;
    fp.lReplacement[k1*k3] = k1p*k3m+k3p*k1m-K1*K3;
    fp.lReplacement[m] = 1;
    fp.lReplacement[kp] = 1;
    fp.lReplacement[zz] = z0;
    
    fp.tReplacement[p*p] = m2;
    fp.tReplacement[n*n] = 0;
    fp.tReplacement[n*p] = pp;
    fp.tReplacement[m] = 1;
    fp.tReplacement[kp] = 1;
    fp.tReplacement[zz] = z0;
    
    fp.nReplacement[zz] = z0;
    fp.nReplacement[z(1)] = ex(1)/3;
    fp.nReplacement[z(2)] = ex(1)/3;
    fp.nReplacement[z(3)] = ex(1)/3;
    
    cout << endl << "Starting @ " << now() << endl;
    
    SecDec work;
    work.eps_lst = lst { lst{ep, 1} };
    Verbose = 100;
        
    work.Initialize(fp);
    
    for(auto &kv : work.FunExp) {
        int xn = kv.op(2).op(0).nops();
        exmap z2x;
        lst zs;
        ex zFactor = 1;
        for(int i=1; i<=fp.tLoopMomenta.nops(); i++) {
            z2x[z(i)] = x(xn+i-1);
            zs.append(x(xn+i-1));
            zFactor /= x(xn+i-1);
        }
        let_op_append(kv, 2, zs);
        
        kv.let_op(0).let_op(0) = kv.op(0).op(0) * zFactor;
        kv.let_op(0) = subs(ex_to<lst>(kv.op(0)), z2x);
        
        auto tmp = collect_common_factors(kv.op(0).op(0));
        if(tmp.has(x(wild())) && is_a<mul>(tmp)) {
            ex rem = 1;
            for(auto item : tmp) {
                if(!item.has(x(wild()))) {
                    rem *= item;
                } else if(item.match(pow(wild(0), wild(1)))) {
                    let_op_append(kv, 0, item.op(0));
                    let_op_append(kv, 1, item.op(1));
                } else {
                    let_op_append(kv, 0, item);
                    let_op_append(kv, 1, 1);
                }
            }
            kv.let_op(0).let_op(0) = rem;
        } else if(tmp.has(x(wild())) && tmp.match(pow(wild(0), wild(1)))) {
            kv.let_op(0).let_op(0) = 1;
            let_op_append(kv, 0, tmp.op(0));
            let_op_append(kv, 1, tmp.op(1));
        }
    }

    work.Normalizes();
    work.XReOrders();
    work.Normalizes();
    
    work.RemoveDeltas();
    work.SDPrepares();
    work.EpsExpands();
    work.CIPrepares();
    work.Contours();
    work.Integrates();
    
    cout << "Finished @ " << now() << endl << endl;
    
    cout << work.VEResult() << endl;
    cout << "check with:" << endl;
    cout << "1.4207211885(4)E3+ep^(-1)*(-3.0454779295(0)E2)+(-5.03299776(1)E3)*ep" << endl;
    
    return 0;
}
