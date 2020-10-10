#.init.sh

clear
echo "-----------------------"
echo "Initializing HepLib ..."
echo "-----------------------"
CWD=$PWD
cd $HOME

# download
#wget https://users.hepforge.org/~f.feng/repl.it.tgz
#tar zxf repl.it.tgz

# non-download
tar zxf $CWD/.repl.it.tgz

rm repl.it.tgz
clear
