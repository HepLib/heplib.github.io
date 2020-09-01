Examples of HepLib
===

Usage within C++
------
Assuming the `<HepLib Install Path>/bin` is added to the environment variable `PATH` , if not please run 
```bash
export PATH=<HepLib Install Path>/bin:$PATH
```
 `<HepLib Install Path>/lib` is added to the environment variable `LD_LIBRARY_PATH`, if not please run 
 ```bash
 export LD_LIBRARY_PATH=<HepLib Install Path>/lib: $LD_LIBRARY_PATH
 ```
 We can compile the [hello.cpp](hello.cpp) and run it like this:
```bash
$ heplib++ -o hello hello.cpp 
$ ./ hello
-4*D*p2.p1+8*p2.p1
```





