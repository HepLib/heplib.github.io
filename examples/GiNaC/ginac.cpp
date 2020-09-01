#include "SD.h"
#include "mpreal.h"

using namespace HepLib::SD;

return_type_t m = make_return_type_t<matrix>();
auto nc = return_types::noncommutative;
DECLARE_FUNCTION_1P(GAD);
REGISTER_FUNCTION(GAD, do_not_evalf_params().set_return_type(nc, &m));
DECLARE_FUNCTION_1P(GSD);
REGISTER_FUNCTION(GSD, do_not_evalf_params().set_return_type(nc, &m));

int main(int argc, char** argv) {

    //SecDec::debug = true;

    auto ep = SD::ep;
    
    if(false) {
        
        lst olst = lst{ lst{x(1),2}, lst{3,x(4)}};
        cout << olst << endl;
        
        exset xset;
        ex tmp = olst;
        find(olst, x(wild()), xset);
        
        cout << xset << endl;
    }
    
    // exmap assign and copy
    if(false) {
        map<int, int> a;
        a[1] = 1;
        a[2] = 2;
        
        auto b = a;
        b[1] = 100;
        b[2] = 200;
        
        for(auto kv : a ) cout << kv.first << ":" << kv.second << endl;
        for(auto kv : b ) cout << kv.first << ":" << kv.second << endl;
    }
    
    if(false) {
        lst a = {1,2,3,4,5,6,7,8,9};
        cout << a.op(-1) << endl;
    }
    
    if(false) {
        symbol a("a");
        ex is;
        cout << is_a<symbol>(a) << ", " << is_a<symbol>(is) << endl;
        is = a;
        cout << is_a<symbol>(a) << ", " << is_a<symbol>(is) << endl;
    }
    
    if(false) {
        ex inn = pow(x(0)+x(1)*(y(1)+y(2)+x(3)),3) * pow(x(1)+y(2)+z(4),5);
        cout << inn << endl;
        cout << mma_collect(inn, x(w), true, true) << endl;
    }
    
    if(false) {
        ex inn = pow(x(0)+x(1)*(y(1)+y(2)+x(3)),3) * pow(x(1)+y(2)+z(4),5);
        cout << inn << endl;
        cout << mma_collect(inn, x(w), true, true) << endl;
    }
    
    if(false) {
        symbol a("a"), b("b"), c("c");
        symtab st;
        ex inex = str2ex("(a+b+c+d+e+f)*VF(a+b+c+d+e+f)+CVF(a+b+c+d+e+f)", st);
        
        auto oo = mma_expand(inex, x(w));
        
        auto ss = gather_symbols(oo);
        
        cout << oo << endl;
        
        cout << ex_to<symbol>(ss.op(0)).get_name() << endl;
        
        cout << oo.subs(ss.op(0)==1) << endl;
        
    
    }
    
    if(false) {
        symtab st;
        ex inex = str2ex("a+b+(5*x(2)*x(3)+x(2)^2+x(4)+4*x(3)^2)*(4*x(3)*x(4)+2*x(1)+4*x(4)+x(2)*x(4))*(x(2)+4*x(3))*(2*x(2)^2*x(4)+x(2)^2*x(1)+10*x(2)*x(3)*x(4)+8*x(3)^2*x(4)+5*x(2)*x(3)*x(1)+4*x(3)^2*x(1))*(8*x(2)^2*x(0)*x(4)^2+4*x(2)^2*x(1)*x(0)*x(4)+40*x(2)*x(3)*x(0)*x(4)^2+16*x(3)^2*x(1)*x(4)^2+20*x(2)*x(3)*x(1)*x(0)*x(4)+4*x(2)^2*x(1)*x(4)^2+20*x(2)*x(3)*x(1)*x(4)^2+32*x(3)^2*x(0)*x(4)^2+8*x(3)^2*x(1)^2*x(4)+x(3)^2*x(1)^3+2*x(2)^2*x(1)^2*x(4)+16*x(3)^2*x(1)*x(0)*x(4)+10*x(2)*x(3)*x(1)^2*x(4))*(10*x(2)*x(3)*x(1)*x(4)+16*x(3)^2*x(0)*x(4)+2*x(2)^2*x(1)*x(4)+8*x(3)^2*x(1)*x(0)+x(2)^2*x(1)^2+2*x(2)^2*x(1)*x(0)+20*x(2)*x(3)*x(0)*x(4)+8*x(3)^2*x(1)*x(4)+4*x(2)^2*x(0)*x(4)+10*x(2)*x(3)*x(1)*x(0)+4*x(3)^2*x(1)^2+5*x(2)*x(3)*x(1)^2)*(x(2)+x(3))", st);
        
        cout << mma_collect(inex, x(w), true, true) << endl;
        cout << gather_symbols(inex) << endl;
        
        
            
    }
    
    if(false) {
        ex oo = lst{1,2,3,4};
        vector<ex> ov;
        ov.push_back(oo);
        for(auto oo : ov) {
            cout << oo << endl;
        }
        
        for(auto &oo : ov) {
            let_op_append(oo, 5);
        }
        
        for(auto oo : ov) {
            cout << oo << endl;
        }
    }
    
    if(false) {
        Digits = 30;
        cout << (pow(SD::ep ,2)+ 3/ex(4)).evalf()  << endl;
    }


    if(false) {
        symtab st;
        ex inex = str2ex("(50*x(0)+25*x(1)+32*x(2))*(2*x(0)+x(1))*(328*x(0)^2*x(2)+200*x(0)^3+90*x(1)^2*x(2)+25*x(1)^3+150*x(0)*x(1)^2+128*x(0)*x(2)^2+344*x(0)*x(1)*x(2)+80*x(1)*x(2)^2+300*x(0)^2*x(1))*(4608*x(0)*x(1)^2*x(2)^3+134400*x(0)^4*x(1)*x(2)+150000*x(0)^4*x(1)^2+4096*x(0)^2*x(1)*x(2)^3+140800*x(0)^3*x(1)^2*x(2)+37500*x(0)^2*x(1)^4+1280*x(1)^3*x(2)^3+120000*x(0)^5*x(1)+16320*x(0)*x(1)^3*x(2)^2+51200*x(0)^5*x(2)+2400*x(1)^4*x(2)^2+40000*x(0)^6+43264*x(0)^3*x(1)*x(2)^2+7500*x(0)*x(1)^5+625*x(1)^6+16384*x(0)^4*x(2)^2+73600*x(0)^2*x(1)^3*x(2)+2000*x(1)^5*x(2)+19200*x(0)*x(1)^4*x(2)+100000*x(0)^3*x(1)^3+256*x(1)^2*x(2)^4+40576*x(0)^2*x(1)^2*x(2)^2)*(2500*x(0)*x(1)+625*x(1)^2+2500*x(0)^2+1024*x(2)^2+1600*x(1)*x(2)+3200*x(0)*x(2))*(2*x(0)+x(1)+2*x(2))*(128*x(0)^2*x(2)+200*x(0)^3+40*x(1)^2*x(2)+25*x(1)^3+150*x(0)*x(1)^2+144*x(0)*x(1)*x(2)+16*x(1)*x(2)^2+300*x(0)^2*x(1))", st);
        
        cout << mma_collect(inex, x(w), true, true) << endl;
                
            
    }
    
    
    if(false) {
    
    symtab st;
    ex inex = str2ex("(x(1)^2+60*x(2)*x(0)+2*(16*x(2)+x(0))*x(1))*(8*x(0)*x(1)^6+32*x(2)^3*x(1)^4+86400*x(2)^4*x(0)^2+96*x(2)^3*x(0)^2*x(1)^2+240*x(2)*x(0)^3*x(1)^3+24576*x(2)^4*x(1)^2+36*x(2)^2*x(1)^5+84*x(2)*x(0)*x(1)^5+96*x(2)^2*x(1)^4+32256*x(2)^3*x(0)^2*x(1)+528*x(2)^2*x(0)*x(1)^3+92160*x(2)^4*x(0)*x(1)+576*x(2)^2*x(0)^3*x(1)+336*x(2)^2*x(0)^2*x(1)^3+192*x(2)^2*x(0)*x(1)^4+12*x(2)*x(1)^6+16*x(0)^4*x(1)^3+32*x(0)^3*x(1)^4+960*x(2)^2*x(0)^2*x(1)^2+216*x(2)*x(0)^2*x(1)^4+96*x(2)*x(0)^4*x(1)^2+24*x(0)^2*x(1)^5+17280*x(2)^3*x(0)^3+112*x(2)^3*x(0)*x(1)^3+x(1)^7+19488*x(2)^3*x(0)*x(1)^2+3840*x(2)^3*x(1)^3+192*x(2)^2*x(0)^3*x(1)^2)*(2*x(0)+x(1))*(18*x(0)*x(1)^4+15*x(0)*x(1)^5+168*x(2)*x(0)^3*x(1)^2+36*x(0)^2*x(1)^3+264*x(2)*x(0)^2*x(1)^3+4128*x(2)^2*x(0)*x(1)^2+864*x(2)*x(0)^3*x(1)+24*x(0)^3*x(1)^2+72*x(2)^2*x(1)^4+138*x(2)*x(0)*x(1)^4+52*x(0)^3*x(1)^3+276*x(2)^2*x(0)*x(1)^3+1344*x(2)*x(0)^2*x(1)^2+4320*x(2)^2*x(0)^3+264*x(2)^2*x(0)^2*x(1)^2+24*x(2)*x(1)^5+696*x(2)*x(0)*x(1)^3+768*x(2)^2*x(1)^3+24*x(0)^4*x(1)^2+120*x(2)*x(1)^4+2*x(1)^6+42*x(0)^2*x(1)^4+7344*x(2)^2*x(0)^2*x(1)+3*x(1)^5+120*x(2)^3*x(0)*x(1)^2+64*x(2)^3*x(1)^3)*(16*x(2)*x(1)+6*x(0)^2+2*x(1)^2+30*x(2)*x(0)+7*x(0)*x(1))*(4*(15*x(0)+8*x(1))*x(2)+x(1)^2+2*x(0)*x(1))*(8*x(2)*x(1)+x(1)^2+12*x(2)*x(0)+2*x(0)*x(1))*(2*x(2)+2*x(0)+x(1))*(32*x(2)*x(1)+x(1)^2+60*x(2)*x(0)+2*x(0)*x(1))", st);
    
    cout << mma_collect(inex, x(w), true, true) << endl;
        

    }
    
    
    
    symbol a("a"), b("b");
    cout << GAD(a)*b*GAD(b)-GAD(b)*GAD(a)*a << endl;
    
    
    return 0;
}
