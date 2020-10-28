#!/usr/bin/env python3

from HepLib import *

ia = Index("ia");
ib = Index("ib");

p1 = Vector("p1");
p2 = Vector("p2");

a = Symbol("a");
b = Symbol("b");
c = Symbol("c");

res = TR(GAS(ia)*GAS(ib)*GAS(a*p1+b*p2)*GAS(ia)*GAS(ib)*GAS(p1));

res = form(res);
print(res);

print(res.factor())
try:
    print(series(res,a+b,0))
except:
    print("Error captured.");


