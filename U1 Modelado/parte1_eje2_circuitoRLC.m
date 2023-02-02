% parte1_eje2_circutioRLC.m
% Resuleve tensión del capacitor en un sistema RLC Serie

%constantes del sistema:
R=10;
C=0.1e-3;
L=30;

p1=-R/(2*L)+sqrt(R^2/4/L^2-1/L/C);
p2=-R/(2*L)-sqrt(R^2/4/L^2-1/L/C);

% Sistema de ecuaciones diferenciales
% dx1=x2
% dx2=-R/L*x2 -1/(LC)*x1
f=@(t,x)[x(2);-R/L*x(2)-1/(L*C)*x(1)];

% dx1=-R/L*x1 -1/(LC)*x2
% dx2=x1
% f2=@(t,x)[-R/L*x(1)-1/(L*C)*x(2);x(1)];

% condiciones iniciales
vc0=1;
dvc0=0;

% tiempo final de simulación
tfin=10;

[t,xsol]=ode45(f,[0 tfin],[vc0 dvc0]);
figure
plot(t,xsol(:,1))


