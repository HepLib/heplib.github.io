#include "HepLib.h"

// interface to Form

using namespace std;
using namespace HepLib;

Form form;
void RunForm(const string & code, const string o = "[o]") {
    cout << "input: " << code << endl;
    cout << "---" << endl;
    string ostr = form.Execute(code,o);
    string_trim(ostr);
    cout << WHITE << ostr << RESET << endl;
    cout << endl;
}

int main() {

    form.Init();
    
    // https://www.nikhef.nl/~form/maindir/documentation/tutorial/online/online.html
    
    // Our First Example
    
    string script = R"EOF(
    Symbols a,b;
    Local [(a+b)^2] = (a+b)^2;
    )EOF";
    RunForm(script,"[(a+b)^2]");
    
    // Exercises
    
    script = R"EOF(
    Symbol a;
    Functions B, C;
    Local F1 = (a+B+C)^2;
    Local F2 = (a+(B+C))^2;
    )EOF";
    RunForm(script,"F1");
    RunForm("", "F2"); // get F2 result
    
    // Functions
    
    script = R"EOF(
    Functions f,g;
    CFunctions F,G;
    Symbol x;
    Off statistics;
    Local F1 = f(x)*g(x) + g(x)*f(x);
    )EOF";
    RunForm(script,"F1");
    
    script = R"EOF(
    Symbols x1,x2,x3,x4,x5;
    Functions S(symmetric), A(antisymmetric), C(cyclic), R(rcyclic);
    Local [o1] = S(x2,x3,x4,x1,x5);
    Local [o2] = A(x2,x3,x4,x1,x5);
    Local [o3] = C(x2,x3,x4,x1,x5);
    Local [o4] = R(x2,x3,x4,x1,x5);
    )EOF";
    RunForm(script,"[o1]");
    RunForm("","[o2]");
    RunForm("","[o3]");
    RunForm("","[o4]");
    
    // Function Calls
    
    script = R"EOF(
    Symbols x,y;
    Commuting f;
    Local F1 = f(x)+f(x,y)+f(x,,y);
    )EOF";
    RunForm(script,"F1");
    
    script = R"EOF(
    Symbol x;
    Local F1 = invfac_(3) + x*fac_(3);
    Local F2 = cos_(0) + cos_(x)^2 + sin_(x)^2;
    Local F3 = x^3*sign_(3) + x*abs_(-1/2) + sig_(-3) + sig_(x);
    Local F4 = binom_(5,2) + sqrt_(4) + x*root_(2,4);
    Local F5 = bernoulli_(0) + bernoulli_(1)*x + bernoulli_(2)*x^2;
    Local F6 = max_(1/2,2) + min_(1,x);
    Local F7 = mod_(7,2);
    )EOF";
    RunForm(script,"F1");
    RunForm("","F2");
    RunForm("","F3");
    RunForm("","F4");
    RunForm("","F5");
    RunForm("","F6");
    RunForm("","F7");
    
    // Vectors and Indices
    
    script = R"EOF(
    Vectors u,v;
    Indices i,j;
    Function f;
    Local w1 = u(1) + v(i);
    Local w2 = u(i) * v(j);
    Local w3 = u(i) * u(i);
    Local w4 = v(i) * u(i);
    Local w5 = f(i,j) * u(i) * v(j);
    )EOF";
    RunForm(script,"w1");
    RunForm("","w2");
    RunForm("","w3");
    RunForm("","w4");
    RunForm("","w5");
    
    script = R"EOF(
    Vector u;
    Index i=0;
    Local P = u(i) * u(i);
    )EOF";
    RunForm(script,"P");
    
    // Tensors
    
    script = R"EOF(
    Tensors SS,TT;
    Indices i,j,k,l;
    Local F1 = SS(i,k)*TT(k,j) + SS(i,l)*TT(l,j);
    )EOF";
    RunForm(script,"F1");
    
    script = R"EOF(
    Tensor t;
    Vector u,v;
    Indices i,j,k;
    Local F1 = v(i)*v(j)*v(k)*v(1);
    Local F2 = v;
    Local F3 = (u.v)^2 * v.v;
    ToTensor v,t;
    .sort
    Local F4 = t;
    ToVector t,v;
    )EOF";
    RunForm(script,"F1");
    RunForm("","F2");
    RunForm("","F3");
    RunForm("","F4");
    
    // error example
    try {
        RunForm("L [o]=z+23;");
    } catch(Error &e) {
        cout << "Error: " << e.what() << endl;
    }
    cout << endl;
    
    form.Exit();
                
    return 0;
}
