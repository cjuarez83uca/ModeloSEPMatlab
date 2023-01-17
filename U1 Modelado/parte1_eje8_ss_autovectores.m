% circuto RLC - Serie
% Datos del sistema:
R= 100; C= 0.1e-3; L= 30;
% condiciones iniciales
Vc0=10; I0=0;
x10=C*Vc0; x20=I0;
x0=[x10; x20];
% Datos del tiempo
tsimu=1;
% formulación en representación en espacio de estado
As=[0 1;-1/L/C -R/L];
Bs=[0;1/L];
Cs=[0 1;1/C 0;0 R;-1/C -R];
Ds=[0;0;0;1];

[v,l,w]=eig(As);

syms s
I=eye(size(As,1));
FT=Cs*inv(s*I-As)*Bs+Ds;