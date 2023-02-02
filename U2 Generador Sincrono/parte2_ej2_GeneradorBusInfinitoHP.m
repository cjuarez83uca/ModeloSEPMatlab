% parte2_ej2_GeneradorBusInfinitoHP.m
% parámetros de simulink
KD=10;
H=3.5; % MWs/MVA
w0=2*pi*60; %rad/seg
K1=0.7643;
K2=0.8649;
K3=0.3230;
K4=1.4187;
T3=2.365;

Efd=0;


sim('parte2_ej2_GBHP.slx')
sys=linmod('parte2_ej2_GBHP')




