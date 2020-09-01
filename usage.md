
Usage within C++
------
The usage of **HepLib** is similar to other `C++` library by including the proper header files in the `C++` source code, compiling the program and linking with HepLib and other necessary libraries. The following code shows how to perform the D-dimensional trace on a Dirac-γ chain Tr[p/1γμ(p/2 + m)γμ] and print the resutl at end:

Assuming the `<HepLib Install Path>/bin` is added to the environment variable `PATH` , if not please run 
```bash
export PATH=<HepLib Install Path>/bin:$PATH
```
 `<HepLib Install Path>/lib` is added to the environment variable `LD_LIBRARY_PATH`, if not please run 
 ```bash
 export LD_LIBRARY_PATH=<HepLib Install Path>/lib:$LD_LIBRARY_PATH
 ```
 We can compile the [hello.cpp](examples/hello.cpp.md) and run it like this:
```bash
$ heplib++ -o hello hello.cpp 
$ ./ hello
-4*D*p2.p1+8*p2.p1
```





