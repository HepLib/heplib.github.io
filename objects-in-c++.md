# Objects in C++

| Object      | Example               | Description                                                  |
| ------------ | ---------------------- | ------------------------------------------------------------ |
| `Symbol`     | `Symbol("s")`          | a real variable `s`.                                         |
| `Index`      | `Index("mu",Type::VD)` | a Lorentz index `mu` with dimension `d`.     |
|              | `Index("mu",Type::CA)` | a color index `a` with dimension `NA`. |
|              | `Index("mu",Type::CF)` | a color index `i` with dimension `NF`. |
| `Vector`     | `Vector("p")`          | a vector/momentum `p`.                           |
| `Pair`       | `Pair(mu,nu)`         | a Kronecker delta $$\delta_{\mu\nu}$$ with `Index` `mu` and `nu`. |
|              | `Pair(p,mu)`           | a `Vector` `p` with Lorentz `Index` `mu`, $$p^\mu$$, `p.mu`. |
|              | `Pair(p,q)`            | a scalar product $$p\cdot q$$ between `Vector`  `p` and `q`. |
| `SUNT`       | `SUNT(a,i,j)`          | a `T`-matrix element $$T^a_{ij}$$ for `SU(N)` group.         |
|              | `SUNT(lst{a,b,c},i,j)` | a matrix element of a product of `T`, $$(T^aT^bT^c)_{ij}$$.  |
| `SUNF`       | `SUNF(a,b,c)`          | a structure constant $$f^{abc}$$ of `SU(N)` group.         |
| `SUNF4`      | `SUNF4(a,b,c,d)`       | a contract of two `SUNF`, $$f^{abe} f^{ecd}$$.              |
| `Eps`        | `Eps(mu1,mu2,mu3,mu4)` | a Levi-Civita tensor $$\varepsilon_{\mu_1\mu_2\mu_3\mu_4}$$. |
|              | `Eps(p1,p2,mu1,mu2)`   | a partially contracted Levi-Civita tensor $$\varepsilon_{p_1p_2\mu_1\mu_2}$$. |
|              | `Eps(p1,p2,p3,p4)`     | a fully contracted Levi-Civita tensor $$\varepsilon_{p_1p_2p_3p_4}$$. |
| `DGamma` | `DGamma(mu,l)` | a Dirac-$$\gamma$$ matrix $$\gamma_\mu$$ for a fermion line `l`. |
|              | `DGamma(p,l)` | a Dirac slash $$p\!\!\!/=p^\mu\gamma_\nu$$ for a fermion line `l`. |
|              | `DGamma(1/5/6/7,l)` | a unit matrix, $$\gamma_5$$, $$\gamma_6$$, $$\gamma_7$$ for a fermion line `l`. |
|`SP`  | `SP(mu,nu)` | evaluated to $$\delta_{\mu\nu}$$. |
| | `SP(p+s*q,mu)` | evaluated to $$p^\mu+sq^\mu$$. |
| | `SP(2*p+q,p+s*q)` | evaluated to $$2p^2+(2s+1)p\cdot q+sq^2$$. |
|`GAS` | `GAS(mu)` | evaluated to $$\gamma_\mu$$. |
| | `GAS(3*p+s*q)` | evaluated to $$3p\!\!\!/+sq\!\!\!/$$. |
| | `GAS(1/5/6/7)` | evaluated to a unit matrix, $$\gamma_5$$, $$\gamma_6$$, $$\gamma_7$$, respectively. |
|`LC` | `LC(p,mu,p+s*q,k)` | evaluated to $$s\varepsilon_{kph\mu}$$. |
|`TR` | `TR(expr)` | a wrapper for the Dirac trace of expression `expr`. |
|`TTR` | `TTR(lst{a,b,c,d})` | a wraaper for the `SU(N)` trace of $$T^aT^bT^cT^d$$. |
| `form` | `form(expr)` | evaluate the expression `expr` using `FORM` program. |

