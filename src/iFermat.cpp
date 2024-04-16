#include "HepLib.h"

// interface to fermat

using namespace std;
using namespace HepLib;

Fermat fermat;
void RunFermat(const string & code) {
    cout << "input: " << code << endl;
    cout << "---" << endl;
    string ostr = fermat.Execute(code);
    cout << WHITE << ostr << RESET << endl;
    cout << endl;
}

int main() {

    fermat.Init();
    
    // examples from: http://home.bway.net/lewis/fermat/osl.html
    
    RunFermat("x:=8+23;");
    RunFermat("y:=(x-29)*x-60");
    RunFermat("Function F(t)=(t-29)*t-60.");
    RunFermat("y:=F(x);");
    RunFermat("F(27+y+1);");
    RunFermat("&(R='stuff');");
    RunFermat("![x");
    RunFermat("Det[x]");
    RunFermat("&(J=t)");
    RunFermat("[y]:=[x]-[t]");
    RunFermat("![y");
    RunFermat("w:=Det[y]");
    RunFermat("w#[x]");
    RunFermat("&(P=t^2+1,1)");
    RunFermat("1/(t+1)");
    
    // error example
    try {
        RunFermat("z+1");
    } catch(Error &e) {
        cout << "Error: " << e.what() << endl;
    }
    
    fermat.Exit();
                
    return 0;
}
