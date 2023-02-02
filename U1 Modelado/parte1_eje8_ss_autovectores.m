% parte1_eje8_ss_autovectores.m
% circuito RLC - Serie
% Datos del sistema:
R= 100; C= 0.1e-3; L= 30;
% condiciones iniciales
Vc0=10; I0=0;
x10=Vc0; x20=I0/C;
x0=[x10; x20];

% formulación en representación en espacio de estado
As=[0 1;-1/L/C -R/L];
Bs=[0;1/L];
Cs=[0 1;1/C 0;0 R;-1/C -R];
Ds=[0;0;0;1];
 
[v,l,w]=eig(As);

p1=-R/(2*L)+sqrt(R^2/4/L^2-1/L/C);
p2=-R/(2*L)-sqrt(R^2/4/L^2-1/L/C);
