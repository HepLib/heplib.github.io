#main.sh

CWD=$PWD
source .bashrc
which heplib++ > /dev/null || ./.init.sh
clear
echo "Basic usage:"
echo "------------------------------"
echo "compile codes/trace.cpp"
echo "------------------------------"
echo "1. source .bashrc"
source .bashrc
echo "2. cd codes"
cd codes
echo "3. heplib++ -o trace trace.cpp"
heplib++ -o trace trace.cpp
echo "4. ./trace"
./trace
cd $CWD
