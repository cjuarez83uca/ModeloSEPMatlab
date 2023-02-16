clear all
close all

FHP=0.3;
FIP=0.3;
FLP=0.4;
TCH=0.3;
TRH=7;
TCO=0.5;

num=[FHP*TRH 1];
den=conv([TCH 1],[TRH 1]);

sys_TGov=tf(num,den);

step(sys_TGov)


title('Turbina de vapor')

