About HepLib
------------
  **HepLib** is a C++ library for computations in **High Energy Physics** the underlying core language is **GiNaC**, which is also a C++ library used to perform symbolic computations. 
  
  HepLib combines serval well-known packages to get the high efficiency, including **Qgraf** to generate the Feynman aptitudes, **FORM** to perform Dirac and Color matrix related computations, and **FIRE** or **KIRA** for the IBP (Integration by Parts) reduction. 
  
  Another core feature of **HepLib** is the numerical evaluation of Master Integrals using sector decomposition, we present another implementation in the language of `C++` with many new features. We use **GiNaC** to handle the symbolic operations, and export the corresponding integrand into an optimized `C++` code, that will be compiled internally and linked dynamically, a customizable numerical integrator is chosen to perform the numerical integration with different float precisions, including the arbitrary precision supported by **MPFR**.
  
Use HepLib
------
+ [How to Install HepLib](#!install.md)
+ [Basic usage of HepLib](#!usage.md)
+ [Examples using HepLib](#!example.md)
+ [Document of HepLib](/doc/)
