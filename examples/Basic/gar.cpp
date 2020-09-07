#include "HepLib.h"

using namespace std;
using namespace HepLib;

int main(int argc, char** argv) {

    map<string,ex> exMap;
    Symbol a("a"), b("b"), c("c");
    
    ex item1 = pow(a+b+c,5);
    ex item2 = log(a+b+ex(1)/5);
    
    exMap["item1"] = item1;
    exMap["key2"] = item2;
    
    cout << "export exMap to out.gar:" << endl;
    garWrite("out.gar", exMap);
    cout << endl;
    
    cout << "$ ls -l ." << endl << "------" << endl;
    system("ls -l .");
    cout << endl;
    
    // read a single item
    ex item1_gar = garRead("out.gar", "item1");
    cout << "item1 from out.gar: " << item1_gar << endl;
    cout << endl;
    
    // read all items to a map
    cout << "read all items: " << endl;
    map<string,ex> oMap;
    garRead("out.gar", oMap);
    for(auto kv : oMap) {
        cout << kv.first << " :> " << kv.second << endl;
    }
    cout << endl;
    
    cout << "one can also use the binary program: garview" << endl;
    cout << "$ garview out.gar" << endl << "------" << endl;
    ostringstream oss;
    oss << "LD_LIBRARY_PATH=" << getenv("LD_LIBRARY_PATH") << " garview out.gar";
    system(oss.str().c_str());
    cout << endl;
    
    return 0;
}
