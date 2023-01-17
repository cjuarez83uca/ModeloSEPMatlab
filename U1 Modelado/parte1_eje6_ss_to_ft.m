% ss_to_ft.m

syms L C R s % declaración de variables simbólicas

As=[0 1;-1/L/C -R/L];
Bs=[0; 1/L];
Cs=[0 1;1/C 0;0 R;-1/C -R];
Ds=[0 0 0 1]';
I=eye(2);
FT=Cs*inv(s*I-As)*Bs+Ds;
