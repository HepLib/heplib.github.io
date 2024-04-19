# Objects in Python

### Python Class: `expr`

A `Python` wrapper class for the inner `GiNaC::ex` object `_expr`.

* `expr(i)`  contructor from an integer `i`.
* `expr(s)` constructor from a `string` `s`.
* `nops()` return the `_expr.nops()`.
* `op(i)` return the `_expr.op(i)`.
* `let_op(i,e)` update the inner `i`th item by `_expr.let_op(i)=e`.
* `expand()` return `_expr.expand()`.
* `normal()` return `_expr.normal()`.
* `factor()` return `_expr.factor()`.
* `series(s,o)` return `mma_series(_expr,s,o)`.
* `subs(e)` return `_expr.subs(e)`.
* `isSymbol()` check the `_expr` is a `Symbol`.
* `isVector()` check the `_expr` is a `Vector`.
* `isIndex()` check the `_expr` is a `Index`.
* `isPair()` check the `_expr` is a `Pair`.
* `isDGamma` check the `_expr` is a `DGamma`.
* `map(map_func)` return the `_expr.map(map_func)`, `map_func` is an object derived from `MapFunction` class.

### Python Functions

* `expand(e)` is equivalent to `e.expand()`.
* `normal(e)` is equivalent to `e.normal()`.
* `factor(e)` is equivalent to `e.factor()`.
* `series(e,s,n)` is equivalent to `e.series(s,n)`.
* `subs(e,es)` is equivalent to `e.subs(es)`.
* `pow(e,n)` return the power $$e^{n}$$.
* `Symbol(s)` return an `expr` object with `_expr=HepLib::Symbol(s)`.
* `Index(s)` return an `expr` object with `_expr=HepLib::FC::Index(s)`.
* `Vector(s)` return an `expr` object with `_expr=HepLib::FC::Vector(s)`.
* `SP(e1,e2)` return an `expr` object with `_expr=HepLib::FC::SP(e1._expr,e2._expr)`.
* `GAS(e)` return an `expr` object with `_expr=HepLib::FC::GAS(e._expr)`.
* `TR(e)` return an `expr` object with `_expr=HepLib::FC::TR(e._expr)`.
* `form(e)` return an `expr` object with `_expr=HepLib::FC::form(e._expr)`.

### Python `call` any `HepLib` function

* `call(func_str,e)` return an `expr` object with `_expr=func(e._expr)`.
* `call(func_str,[e1,e2,...])` return an `expr` object with `_expr=func(e1,e2,...)`.

### Python Class: `Integral`

* `epN` the requested $$\epsilon$$ order.
* `epsN` the requested $$\epsilon^\prime$$ order.
* `verb` the inner `Verbose`.
* `Functions([e1,e2,...])` to assign the internal `Functions` or `Propagators`.
* `Exponents([e1,e2,...])` to assign the internal `Exponents`.
* `Evaluate()` to evaluate the integral by _Sector Decomposition_, the `Integral` object itself holds the nummerical result.

