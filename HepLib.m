(* ::Package:: *)

(* ::Chapter:: *)
(*HepLib*)


(* ::Section::Closed:: *)
(*M2C*)


Unprotect[pow];
Clear[pow];
pow::usage="pow in GiNaC";
Protect[pow];


Clear[M2C];
M2C[exp_]:=Module[{ret},
ret=exp/.Rule->List;
ret=ret/.{EulerGamma->Euler,Zeta->zeta,Gamma->tgamma,Power->pow,Log->log,Sqrt->sqrt};
ret=ToString[InputForm[ret],PageWidth->Infinity];
ret=StringReplace[ret,{"["->"(", "]"->")"}];
ret
];


(* ::Section::Closed:: *)
(*C2M*)


Clear[C2M]
C2M[cex_String]:=Module[{ret},
ret=StringReplace[cex,{
"VE"->"VE","iEpsilon"->"iEpsilon","Euler"->"EulerGamma","zeta"->"Zeta","tgamma"->"Gamma","pow"->"Power","log"->"Log","sqrt"->"Sqrt","E"~~(n:NumberString):>"*10^"<>n,"+-"->"+0*","."~~(n:NumberString):>"."<>n,".":>"~Dot~"
}];
ret=ToExpression[ret,TraditionalForm];
ret=ret/.{psi[ex_]:>PolyGamma[1,ex]};
Return[ret];
];


RE[cex_String]:=C2M[cex]/.Complex[r_,_]:>r


(* ::Section:: *)
(*VE*)


Unprotect[VE];
Clear[VE];
VE::usage="Value and Error Wrapper";
VE/:VE[0,0]:=0;
VE/:VE[Complex[vr_,vi_],Complex[er_,ei_]]:=VE[vr,er]+I VE[vi,ei];
VE/:VE[v_?NumericQ,e_]/;Element[v,Reals]&&v<0:=-VE[-v,e];
VE/:MakeBoxes[VE[v_?NumericQ,0],TraditionalForm]:=With[{vv=N[v,35]},StyleBox[MakeBoxes[vv,TraditionalForm],FontColor->Blue]];
VE/:MakeBoxes[VE[v_?NumericQ,e_/;Abs[e]<=0],TraditionalForm]:=StyleBox[MakeBoxes[v,TraditionalForm],FontColor->Blue];


Clear[CLog];
CLog[ex_]:=Ceiling[Log[10,Abs[ex]]];
CLog[ex_]/;Abs[Rationalize[ex,0]]<Power[10,-100]:=-100;
VEWidth=1;


VE/:MakeBoxes[VE[v0_/;Element[v0,Reals],e0_?NumericQ],TraditionalForm]:=Module[{v,e,n,v1,e1,a,en},
n=Max[CLog[v0],CLog[e0]];
{v,e}={Abs[v0],Abs[e0]}/Power[10,n];
e1=N[Rationalize[e,0],VEWidth];
e1=AccountingForm[e1,VEWidth]//ToString;
If[StringStartsQ[e1,"1."],
e1=StringReplace[e1,"1."->"0.1"];
n=n+1;
v=v/10;
];
a=StringLength[e1]-2;
v=N[Round[v,Power[10,-a]],a+2];
v1=AccountingForm[v]//ToString;
If[v1==="0",v1="0."];
On[Assert];Assert[Or[StringStartsQ[v1,"1."],StringStartsQ[v1,"0."]]];
If[StringLength[v1]<a+2,v1=v1<>StringJoin[Table["0",a+2]]];
v1=StringTake[v1,a+2];
e1=StringTake[e1,-VEWidth];
If[n=!=0,RowBox[{v1,"(",e1,")","\[Times]",SuperscriptBox[10,n]}],RowBox[{v1,"(",e1,")"}]]
];


Protect[VE];


Clear[ChopVE];
ChopVE[exp_,diff_:Power[10,-6]]:=exp/.VE[v_/;Abs[v]<diff,e_/;Abs[e]<diff]->0;


Clear[VESimplify];
VESimplify[exp_,ri_:Null]:=Module[{tmp,VF,VE2,IM,resR,resI},
On[Assert];Assert[SubsetQ[{True},Union[Map[NumericQ,Union[Cases[exp,_Symbol,{0,Infinity}]]]]]];
tmp=Expand[exp];
tmp=tmp/.Complex[a_,b_]:>a+b IM;
tmp=Expand[tmp,_VE|IM];
tmp=Distribute[VF[tmp]];
tmp=tmp/.VF[0]->0;
tmp=tmp/.VF[r_+i_ IM]:>VF[r]+IM VF[i];
tmp=tmp/.VF[ex_]/;FreeQ[ex,_VE]:>VF[VE[ex,0]];
tmp=tmp/.{VF[c_. VE[e_,v_]]/;FreeQ[c,IM]:>VE2[c e,Power[Abs[c] v,2]]};
tmp=tmp/.{VF[c_. IM VE[e_,v_]]:>IM VE2[c e,Power[Abs[c] v,2]]};
On[Assert];Assert[FreeQ[tmp,_VF]];
resR=tmp/.IM->0/.VE2->List;
If[resR=!=0,
On[Assert];Assert[Length[resR]===2];
resR[[2]]=Sqrt[resR[[2]]];
];
resR=VE@@resR;
resI=Coefficient[tmp,IM]/.VE2->List;
If[resI=!=0,
On[Assert];Assert[Length[resI]===2];
resI[[2]]=Sqrt[resI[[2]]];
];
resI=VE@@resI;
tmp=Switch[ri
,Null,resR+resI I
,Re,resR
,Im,I resI];
Return[tmp];
];


Clear[SimplifyVE];
SimplifyVE[exp_]:=VESimplify[exp];


(* ::Section::Closed:: *)
(*UF*)


Clear[UF];
UF[ls_,tls_,ps_,ns_,lr_:{},tlr_:{},nr_:{},isQuasi_:False]:=Module[{exe,proc,err,is,os,es,res},
exe="/usr/local/feng/bin/UF";
proc=StartProcess[exe,ProcessEnvironment-><|"DYLD_LIBRARY_PATH"->"/usr/local/feng/lib"|>];
is=ProcessConnection[proc,"StandardInput"];
os=ProcessConnection[proc,"StandardOutput"];
es=ProcessConnection[proc,"StandardError"];
err=ReadString[es,EndOfBuffer];
If[StringLength[StringTrim[err]]>0,Print[err];Abort[];Return[]];
WriteLine[is,M2C[If[isQuasi,1,0]]];
WriteLine[is,".end"];
WriteLine[is,M2C[ls]];
WriteLine[is,".end"];
WriteLine[is,M2C[tls]];
WriteLine[is,".end"];
WriteLine[is,M2C[ps]];
WriteLine[is,".end"];
WriteLine[is,M2C[ns]];
WriteLine[is,".end"];
WriteLine[is,M2C[lr]];
WriteLine[is,".end"];
WriteLine[is,M2C[tlr]];
WriteLine[is,".end"];
WriteLine[is,M2C[nr]];
WriteLine[is,".end"];
res=ReadString[os,EndOfFile];
If[res===EndOfFile||StringLength[StringTrim[res]]==0,Print[ReadString[es,EndOfBuffer]];Abort[]];
KillProcess[proc];
res
];


(* ::Section:: *)
(*RC*)


SetAttributes[RC,HoldAll];


RCsubs={};


RC[Z2,Gluon]:=1+1/2 \[Alpha]\[Pi] Tf nH (-(2/(3 ep))-(2 lmu)/3-(ep lmu^2)/3-(\[Pi]^2 ep)/18-(ep^2 lmu^3)/9-1/18 \[Pi]^2 ep^2 lmu+2/9 ep^2 Zeta[3]+NoDone[1,2,ep] ep^3)+(\[Alpha]\[Pi]/2)^2 Tf nH (Tf nH ((4 lmu)/(9 ep)+(2 lmu^2)/3+\[Pi]^2/27)+Tf nL (-(4/(9 ep^2))-(4 lmu)/(9 ep)-(2 lmu^2)/9-\[Pi]^2/27)+CF (-(1/(2 ep))-lmu-15/4)+CA (35/(36 ep^2)+(13 lmu)/(18 ep)-5/(8 ep)-(5 lmu)/4+lmu^2/9+13/48+(13 \[Pi]^2)/216)+NoDone[2,0,ep] ep)//. RCsubs;


RC[Z2,LightQuark]:=1+(\[Alpha]\[Pi]/2)^2 CF Tf nH (1/(4 ep)+lmu/2-5/24)//.RCsubs;


RC[Z2,HeavyQuark]:=1+1/2 \[Alpha]\[Pi] CF (-(3/(2 ep))-2-(3 lmu)/2-4 ep-2 ep lmu-(3 ep lmu^2)/4-(\[Pi]^2 ep)/8-8 ep^2-4 ep^2 lmu-ep^2 lmu^2-(ep^2 lmu^3)/4-(\[Pi]^2 ep^2)/6-1/8 \[Pi]^2 ep^2 lmu+1/2 ep^2 Zeta[3]+NoDone[1,2,ep] ep^3)+(\[Alpha]\[Pi]/2)^2 CF (Tf nH (1/(4 ep)+lmu/ep+947/72+(11 lmu)/6+(3 lmu^2)/2-(5 \[Pi]^2)/4)+Tf nL (-(1/(2 ep^2))+11/(12 ep)+113/24+(19 lmu)/6+lmu^2/2+\[Pi]^2/3)+CF (9/(8 ep^2)+51/(16 ep)+(9 lmu)/(4 ep)+433/32+(51 lmu)/8+(9 lmu^2)/4-(49 \[Pi]^2)/16+4 \[Pi]^2 Log[2]-6 Zeta[3])+CA (11/(8 ep^2)-127/(48 ep)-1705/96-(215 lmu)/24-(11 lmu^2)/8+(5 \[Pi]^2)/4-2 \[Pi]^2 Log[2]+3 Zeta[3])+NoDone[2,0,ep] ep)//. RCsubs;


RC[Zm]:=1+1/2 \[Alpha]\[Pi] CF (-(3/(2 ep))-2-(3 lmu)/2-4 ep-2 ep lmu-(3 ep lmu^2)/4-(\[Pi]^2 ep)/8-8 ep^2-4 ep^2 lmu-ep^2 lmu^2-(ep^2 lmu^3)/4-(\[Pi]^2 ep^2)/6-1/8 \[Pi]^2 ep^2 lmu+1/2 ep^2 Zeta[3]+NoDone[1,2,ep] ep^3)+(\[Alpha]\[Pi]/2)^2 CF (Tf nH (-(1/(2 ep^2))+5/(12 ep)+143/24+(13 lmu)/6+lmu^2/2-(2 \[Pi]^2)/3)+Tf nL (-(1/(2 ep^2))+5/(12 ep)+71/24+(13 lmu)/6+lmu^2/2+\[Pi]^2/3)+CF (9/(8 ep^2)+45/(16 ep)+(9 lmu)/(4 ep)+199/32+(45 lmu)/8+(9 lmu^2)/4-(17 \[Pi]^2)/16+2 \[Pi]^2 Log[2]-3 Zeta[3])+CA (11/(8 ep^2)-97/(48 ep)-1111/96-(185 lmu)/24-(11 lmu^2)/8+\[Pi]^2/3-\[Pi]^2 Log[2]+(3 Zeta[3])/2)+NoDone[2,0,ep] ep)//. RCsubs;


lmu:=Log[\[Mu]^2/m^2];


\[Alpha]\[Pi]B:=With[{Nf=nH+nL},Block[{b0=(11 CA)/3-(4 Tf Nf)/3,b1=(34 CA^2)/3-(20 CA Tf Nf)/3-4 CF Tf Nf},\[Alpha]\[Pi]LO (1-(\[Alpha]\[Pi] b0)/(2 (2 ep))+(\[Alpha]\[Pi]/2)^2 (b0^2/(4 ep^2)-b1/(8 ep)))]]//. RCsubs;


\[Alpha]\[Pi]LO=\[Alpha]\[Pi] \[Mu]^(2 ep) (Exp[EulerGamma]/(4 \[Pi]))^ep;


RC[Zas]:=\[Alpha]\[Pi]B/\[Alpha]\[Pi];


Zas0=\[Mu]^(2 ep) (Exp[EulerGamma]/(4 \[Pi]))^ep;


(* ::Section:: *)
(*Plus Function*)


Clear[Delta,PlusFunction];


Delta/:MakeBoxes[Delta[exp_],TraditionalForm]:=RowBox[{"\[Delta]","[",MakeBoxes[exp,TraditionalForm],"]"}]


PlusFunction/:MakeBoxes[PlusFunction[exp_],TraditionalForm]:=SubscriptBox[RowBox[{"[",MakeBoxes[exp,TraditionalForm],"]"}],"+"]


PlusFunctionSeries[z_,-1+a_ ep,n_]:=Delta[z]/(a ep)+Sum[(a ep)^k/k! PlusFunction[Log[z]^k/z],{k,0,n}]


PlusFunction2Series[z_Symbol,-1+a_ ep,n_]:=Gamma[a ep]^2/(2 Gamma[2a ep]) (Delta[z]+Delta[1-z])+Sum[(a ep)^k/k! PlusFunction[Log[z(1-z)]^k/(z(1-z))],{k,0,n}]


Clear[SimplifyPlusFunction];
Options[SimplifyPlusFunction]={Factor->1,Point->1,Variables->z};
SimplifyPlusFunction[exp_,OptionsPattern[SimplifyPlusFunction]]:=Module[{pre,vz,z0,tmp,VF},
pre=OptionValue[Factor];
z0=OptionValue[Point];
vz=OptionValue[Variables];
tmp=exp;
tmp=Collect[tmp,_PlusFunction];
tmp=Distribute[VF[tmp]]/.VF[c_ pf_PlusFunction]:>Factor[pre(
pf Normal@Series[c/pre,{vz,z0,0}]+(c/pre-Normal@Series[c/pre,{vz,z0,0}])(pf/.PlusFunction->Identity)
)];
tmp=tmp/.VF->Identity;
Return[tmp];
];
