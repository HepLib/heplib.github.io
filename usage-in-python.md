# Usage in Python

**HepLib** provides a wrapper class `HepLibW` as an interface to other languages, the **SWIG** interace file `HepLib.i` is also installed `<INSTALL_PATH>/include/HepLib.i`. We will just show the usage within `python`, but it also applys to other languages with the help of **SWIG**.

### Compile the python module

One can use the following _makefile_ to generate the python module files: `_HepLib.so` and `HepLib.py`.

{% tabs %}
{% tab title="python 3.x(>3.8)" %}

```makefile
all: _HepLib.so
HLS=HepLib_SWIG
flatns=""

uname := $(shell uname -s)
ifeq ($(uname),Darwin)
  flatns = "-flat_namespace"
endif

$(HLS).cpp:
        swig -python -c++ -o $(HLS).cpp $$(heplib-config --prefix)/include/HepLib.i
$(HLS).o : $(HLS).cpp
        heplib++ -fPIC -c $(HLS).cpp $$(python3-config --cflags)
_HepLib.so : $(HLS).o
        heplib++ -shared $(flatns) $(HLS).o -o _HepLib.so $$(python3-config --ldflags --embed)
clean:
        rm -f $(HLS)* _HepLib.so HepLib.py
```
{% endtab %}

{% tab title="python 3.8" %}
```makefile
all: _HepLib.so
HLS=HepLib_SWIG
flatns=""

uname := $(shell uname -s)
ifeq ($(uname),Darwin)
  flatns = "-flat_namespace"
endif

$(HLS).cpp:
        swig -python -c++ -o $(HLS).cpp $$(heplib-config --prefix)/include/HepLib.i
$(HLS).o : $(HLS).cpp
        heplib++ -fPIC -c $(HLS).cpp $$(python3-config --cflags)
_HepLib.so : $(HLS).o
        heplib++ -shared $(flatns) $(HLS).o -o _HepLib.so $$(python3-config --ldflags) -lpython3.8
clean:
        rm -f $(HLS)* _HepLib.so HepLib.py
```
{% endtab %}
{% endtabs %}

### Python version for various C++ codes

_Note:_ the various `.cpp` files are introduced in Reference: https://doi.org/10.1016/j.cpc.2021.107982

- `0.py` (python version for `0.cpp`)

```python
#!/usr/bin/env python3

# python version for 0.cpp

from HepLib import *

x = symbol("x")
y = symbol("y")
z = symbol("z")
r = expr("2/3")
print("x ->", x, ", r ->", r)

e1 = r*x+2*y+pow(y,10)
print("e1 ->", e1)
e2 = (x+1)/(x-1)
print("e2 ->", e2)
e3 = sin(x+2*y)+3*z+41
print("e3 ->", e3)
e4 = e3+e2/exp(e1)
print("e4 ->", e4)
print()

x = symbol("x")
y = Symbol("y")
print("x ->", x, ", y->", y)
e1 = conjugate(x)
print("conjugate(x) ->", e1)
e2 = conjugate(y)
print("conjugate(y) ->", e2)
print()
```

- `1.py` (python version for `1.cpp`)

```python
#!/usr/bin/env python3

# python version for 0.cpp

from HepLib import *

expr_str = "WF(1)+x(1)^2+sin(5)+power(a,n)"
e1 = expr(expr_str)
print(e1)
a = Symbol("a")
n = Symbol("n")
e2 = WF(expr(1))+pow(x(1),2)+sin(expr(5))+pow(a,n)
print(e1-e2)

print()

```

- `2.py` (python version for`2.cpp`)

```python
#!/usr/bin/env python3

# python version for 0.cpp

from HepLib import *

x = Symbol("x")
y = Symbol("y")
z = Symbol("z")
n = Symbol("n")
l1 = lst([x, y, x+z])
e1 = pow(sin(x),n)
print("l1 ->", l1)
print("e1 ->", e1)
tot = l1.nops()
print("l1.nops() ->", tot)
item1 = l1.op(0)
print("1st item of l1 ->", item1)
l1.let_op(2, e1)
print("updated l1 ->", l1)
tot = e1.nops()
print("e1.nops() ->", tot)
item2 = e1.op(1)
print("2nd item of e1 ->", item2)
print()
```

- `3.py` (python version for`3.cpp`)

```python
#!/usr/bin/env python3

# python version for 0.cpp

from HepLib import *

x = Symbol("x")
y = Symbol("y")
e0 = expr("x^4+x^3+x^2+x")
print("e0 ->", e0)
e1 = e0.subs([pow(x,w)>>pow(y,w+2)])
print("e1 ->",e1)

class mapClass(MapFunction):
    def map(self, e):
        if(e.match(pow(x,w)) and e.op(1).info("even")):
            return pow(y,e.op(1)+2)
        else:
            return e.map(self)

e2 = mapClass()(e0)
print("e2 ->",e2)

print()
```

- `4.py` (python version for`4.cpp`)

```python
#!/usr/bin/env python3

# python version for 0.cpp

from HepLib import *

x = Symbol("x")
y = Symbol("y")

data = exvec()
total = 100
for i in range(total):
    data.push_back(sin(exp(x+y*i)))

class ParFunRun(ParFun):
    def __call__(self, idx):
        ret = data[idx]
        ret = series(ret,x,5)
        #print("idx:", idx)
        return ret
        
f = ParFunRun()
set_Verbose(100)
set_Parallel_Process(4)
ret = Parallel(total, f)
#print(ret)
```

- `5.py` (python version for`5.cpp`)

```python
#!/usr/bin/env python3

# python version for 0.cpp

from HepLib import *

me = Symbol("me")
mm = Symbol("mm")
e = Symbol("e")
mu = Index("mu")
nu = Index("nu")
p = Vector("p")
P = Vector("P")
k = Vector("k")
K = Vector("K")
q = Vector("q")

letSP(p,me*me)
letSP(P,me*me)
letSP(k,mm*mm)
letSP(K,mm*mm)

def gpm(p, m):
    return GAS(p)+m*GAS(1)

tr1 = TR( gpm(P,-me)*GAS(mu)*gpm(p,me)*GAS(nu) );
tr2 = TR( gpm(k,mm)*GAS(mu)*gpm(K,-mm)*GAS(nu) );
res =  pow(e,4) / (4*pow(SP(q),2)) * tr1 * tr2;
set_form_using_dim4(True)
res = form(res)
res = factor(res);
print(res.subs(me>>0));
print()

set_form_using_su3(True)
a = IndexCA("a")
i = IndexCF("i")
j = IndexCF("j");
tr = TTR([a,a]);
print("tr1 =", form(tr))
tr = SUNT(a,i,j) * SUNT(a,j,i);
print("tr2 =", form(tr))
tr = SUNT([a,a],i,i)
print("tr3 =", form(tr))

print()
```

- `6.py` (python version for`6.cpp`)

```python
#!/usr/bin/env python3

from HepLib import *

A = Symbol("A")
e = Symbol("e")
ebar = Symbol("ebar")
mu = Symbol("mu")
mubar = Symbol("mubar")

p = Vector("p")
P = Vector("P")
k = Vector("k")
K = Vector("K")

me = Symbol("me")
mm = Symbol("mm")

proc = Process()
proc.Model = """
    [e, ebar, -]
    [mu, mubar, -]
    [A, A, +]
    [ebar, e, A]
    [mubar, mu, A]
"""
proc.In = "e[p],ebar[P]"
proc.Out = "mubar[k],mu[K]"
proc.Options = "onshell"
proc.Loops = 0

st = {}
st["p"] = p
st["P"] = P
st["k"] = k
st["K"] = K

amps = proc.Amplitudes(st)

set_InOutTeX(-1,"$e^-(p)$")
set_InOutTeX(-3,"$e^+(P)$")
set_InOutTeX(-2,"$\\mu^+(k)$")
set_InOutTeX(-4,"$\\mu^-(K)$")

set_LineTeX(Symbol("e"),"fermion, edge label=$e$")
set_LineTeX(Symbol("ebar"),"anti fermion, edge label=$e$")
set_LineTeX(Symbol("mu"),"fermion, edge label=$\\mu$")
set_LineTeX(Symbol("mbar"),"anti fermion, edge label=$\\mu$")
set_LineTeX(Symbol("A"),"photon, edge label=$\\gamma$")

Process.DrawPDF(amps, "amps.pdf")

class ClassFR(MapFunction):
    def __init__(self):
        MapFunction.__init__(self)

    def map(self, e):
        if(isFunction(e,"OutField") or isFunction(e,"InField")):
            return expr(1)
        elif(isFunction(e, "Propagator")):
            fi1 = e.op(0).op(1)
            fi2 = e.op(1).op(1)
            mom = e.op(2)
            if(e.op(0).op(0)==A):
                return (-I) * SP(LI(fi1),LI(fi2)) / SP(mom); # Feynman Gauge
            elif(e.op(0).op(0)==ebar):
                return I * Matrix(GAS(mom)+GAS(1)*me, DI(fi1),DI(fi2)) / (SP(mom)-me*me)
            elif(e.op(0).op(0)==mubar):
                return I * Matrix(GAS(mom)+GAS(1)*mm, DI(fi1),DI(fi2)) / (SP(mom)-mm*mm)
        elif(isFunction(e, "Vertex")):
            fi1 = e.op(0).op(1)
            fi2 = e.op(1).op(1)
            fi3 = e.op(2).op(1)
            if(e.op(0).op(0)==ebar):
                return I*Symbol("e")*Matrix(GAS(LI(fi3)),DI(fi1),DI(fi2))
            elif(e.op(0).op(0)==mubar):
                return I*Symbol("e")*Matrix(GAS(LI(fi3)),DI(fi1),DI(fi2))
        else:
            return e.map(self)

amps_FR = ClassFR()(amps[0])
    
print("amps_FR: ")
print(amps_FR);
    
ampL = amps_FR
ampR = IndexL2R(conjugate(ampL));
def SS1(p,m,i):
    return Matrix(GAS(p)+m*GAS(1),DI(i),RDI(i))
def SS2(p,m,i):
    return Matrix(GAS(p)+m*GAS(1),RDI(i),DI(i))

M2 = ampL * ampR * SS1(p,me,-1) * SS2(P,-me,-3) * SS1(k,-mm,-2) * SS2(K,mm,-4);
M2 = MatrixContract(M2);
    
print("M2: ")
print(M2)
print()
    
set_form_using_dim4(True)
letSP(p,me*me)
letSP(P,me*me)
letSP(k,mm*mm)
letSP(K,mm*mm)

res = form(M2);
print("Final M2:")
print(factor(res.subs(me>>0)))
```

- `7.py` (python version for`7.cpp`)

```python
#!/usr/bin/env python3

from HepLib import *

p = Vector("p")
q1 = Vector("q1")
expr = expr(1)/SP(q1) * expr(1)/(2*SP(p,q1)-SP(q1)) * expr(1)/(2*SP(p,q1)+SP(q1))
r = Apart(expr,[q1],[p]);
r1 = ApartIR2ex(r);
r2 = ApartIR2F(r);

print(r)
print()
print(r1)
print()
print(r2)
print()
    
r3 = Apart(expr, [SP(q1),SP(p,q1)])
print(r3)
print()
```

- `8.py` (python version for`8.cpp`)

```python
#!/usr/bin/env python3

import os
from HepLib import *

q1 = Symbol("q1")
p = Symbol("p")
m = Symbol("m")
    
fire = FIRE()
fire.Internal = exvec([ q1 ])
fire.External = exvec([ p ])
fire.Replacements = exvec([ p*p >> m*m ])

fire.Propagators = exvec([ q1*q1, 2*p*q1-q1*q1 ])
fire.Integrals = exvec([ expr("{2,1}") ])
fire.WorkingDir = "IBPdir";
fire.Reduce()

print("Reduced Rules:")
print(fire.Rules)
print("Master Integrals:")
print(fire.MIntegrals)

os.system("rm -rf IBPdir")
```

- `9.py` (python version for`9.cpp`)

```python
#!/usr/bin/env python3

import os
from HepLib import *

k = Symbol("k")
r = Symbol("r")
q = Symbol("q")
p1 = Symbol("p1")
p2 = Symbol("p2")
s = Symbol("s")

fp = FeynmanParameter()
fp.LoopMomenta = exvec([k,r,q]);
fp.Propagators= exvec([ -pow(k,2),-pow(k+p1+p2,2),-pow(-k+r,2),-pow(p1+r,2),-pow(k-q,2),-pow(p1+q,2) ]);
fp.Exponents = exvec(expr("{1+3*ep,1,1,1,1,1}"))
fp.lReplacements[p1*p1] = expr(0)
fp.lReplacements[p2*p2] = expr(0)
fp.lReplacements[p2*p1] = s/2
fp.lReplacements[s] = expr(-1)
fp.Prefactor = pow(I*pow(Pi,2-ep),-3) * pow(tgamma(1-ep),3)
work = SecDec()
set_Verbose(100)
work.Evaluate(fp)
print("Final Result & Error:")
print(work.VE)
```

