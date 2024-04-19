# Utils in HepLib

There are several useful utils installed to the directory `<INSTALL PATH>/bin`.

### heplib++ - HepLib g++

The basic uage:
```bash
heplib++ -o prog prog.cpp
```

The content in this script
```
g++  -I'<INSTALL PATH>/include' -Wl,-rpath,. -Wl,-rpath,'<INSTALL PATH>/lib' -L'<INSTALL PATH>/lib' -lHepLib -lcln -lginac -lMinuit2 -lcubaq -lqhullstatic -lquadmath $@ -lHepLib -lcln -lginac -lMinuit2 -lcubaq -lqhullstatic -lquadmath
```

### sc - Server / Clients

Genernal information of `sc` from `sc --help`
```bash
A simple Server/Client, bypass with [i].log
Supported Options:
  --total: total elements @server.
  --port: server port @server/@client.
  --server: server ip or hostname @client.
  --command: command with [i] replaced @client.
  --round: round to be cycled @server.
```
One can run the following command on the _master_ node
```bash
sc --total 100 --port 1234
```
One will get the message as follows:
```
Started @ 2020-11-17 16:05:27
  Server Port: 1234
  Server: 0 / 99 @ 16:05:2
```
The server is ready to dispatch item (from `0` to `99`) to the connected slave node.

Now one can run the following command on each slave node
```bash
sc --server master-node-host --port 1234 --command "echo [i]"
```
one will see the slave node will repleatly get the item from the server, and exceute the command `echo [i]`, note that `[i]` will replaced by the actual index (form `0` to `99`).

Note that to prevent the command to run multiple times on the same `[i]`, one can generate a `[i].log` from the command, _e.g._,

```bash
sc --server master-node-host --port 1234 --command "echo [i] > [i].log"
```
sc will skip the item `[i]` when there is a file named `[i].log`.
