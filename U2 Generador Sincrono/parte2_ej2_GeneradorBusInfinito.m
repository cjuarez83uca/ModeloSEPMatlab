% parte2_ej2_GeneradorBusInfinito.m
% parámetros de simulink
KD=10;
KS=0.757;%p.u.
H=3.5; % MWs/MVA
w0=2*pi*60; %rad/seg

sim('parte2_ej2_GBClasico.slx')

