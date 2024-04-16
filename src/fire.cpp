#include "HepLib.h"

using namespace std;
using namespace GiNaC;
using namespace HepLib;
using namespace HepLib::FC;
using namespace HepLib::IBP;

int main() {

    Symbol q1("q1"), p("p"), k("k"), m("m"), s("s");
    
    { // case: q1*q1, q1*p-1
        vector<FIRE> fs;
        FIRE fire;
        fire.Internal = lst{ q1 };
        fire.External = lst{ p };
        fire.Replacements = lst{ p*p == m*m };
        
        fire.Propagators = lst{ q1*q1, q1*p-1};
        fire.Integrals.append(lst{1,1});
        fire.Integrals.append(lst{2,2});
        fire.Integrals.append(lst{2,3});
        
        fire.WorkingDir = "IBPdir";
        FIRE::Version = 6;
        
        fire.Export();
        fire.Run();
        fire.Import();
        
        cout << "Reduced Rules:" << endl;
        cout << fire.Rules << endl;
        cout << "Master Integrals:" << endl;
        cout << fire.MasterIntegrals << endl;
        cout << endl;
    }

    { // case: p*q1, k*q1, 2*m*m + 2*k*q1 + 2*p*q1 - q1*q1 - s/2
        FIRE fire;
        fire.Internal = lst{ q1 };
        fire.External = lst{ p, k };
        fire.Replacements = lst{ k*k == 0, k*p == -m*m + s/4, p*p == m*m };
        
        fire.Propagators = lst{ p*q1, k*q1, 2*m*m + 2*k*q1 + 2*p*q1 - q1*q1 - s/2};
        fire.Integrals.append(lst{1,1,3});
        fire.Integrals.append(lst{1,-1,-2});
        fire.Integrals.append(lst{1,1,-3});
        
        fire.WorkingDir = "IBPdir";
        fire.ProblemNumber = 1;
        
        fire.Reduce();
        
        cout << "Reduced Rules:" << endl;
        cout << fire.Rules << endl;
        cout << "Master Integrals:" << endl;
        cout << fire.MasterIntegrals << endl;
        cout << endl;
    }
    
    { // with cut propagators
        Symbol k1("k1"), k2("k2"), k3("k3"), k4("k4"), p("p"), mc("mc");
        
        FIRE fire;
        fire.Internal = lst{k1, k2, k3};
        fire.External = lst{ p };
        fire.Replacements = lst{str2ex("p^2") == str2ex("4*mc^2")};
        
        fire.Propagators = str2lst("{k3^2, k2^2, k1^2, k1^2 + 2*k1*k2 + k2^2 + 2*k1*k3 + 2*k2*k3 + k3^2 + 4*mc^2 - 2*k1*p - 2*k2*p - 2*k3*p, -4*mc^2 + k1*p + k2*p + k3*p, 2*k1*k3 - k1*p - k3*p, 2*k1*k3, 2*k1*k2 - k1*p - k2*p, 2*k1*k2}");
        
        fire.Integrals.append(lst{1, 1, 1, 1, 1, 1, 1, 1, 1});
        fire.Integrals.append(lst{1, 1, 1, 1, 2, 1, 1, 1, 1});
        fire.Cuts = lst{1,2,3,4};
        
        fire.WorkingDir = "IBPdir";
        fire.ProblemNumber = 1;
        
        fire.Reduce();
        
        vector<Base*> fs;
        fs.push_back(&fire);
                
        auto rs = FindRules(fs,true);
        cout << "Reduced Rules:" << endl;
        cout << fire.Rules << endl;
        cout << "Master Integrals:" << endl;
        cout << fire.MasterIntegrals << endl;
        cout << "Relations in MIs:" << endl;
        cout << rs.first << endl;
        cout << endl;
    }
    
    system("rm -rf IBPdir");
    
    return 0;
}
