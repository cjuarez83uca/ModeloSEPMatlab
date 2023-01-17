% circuto RLC - Serie

% Datos del sistema:
R= 10000;
C= 0.1e-3;
L= 30;

% condiciones iniciales
Vc0=10;
pVc0=0;

% Datos del tiempo
h=0.1/10;
ti=0;
tf=1;
t=ti:h:tf;
% Solución analítica
p1=-R/2/L+sqrt(R^2/4/L^2-1/L/C);
p2=-R/2/L-sqrt(R^2/4/L^2-1/L/C);

A1=(Vc0*p2-pVc0)/(p2-p1);
A2=(pVc0-Vc0*p1)/(p2-p1);

Vc=A1*exp(p1*t)+A2*exp(p2*t);
plot(t,Vc)
title('Voltaje de capacitor en Ckto RLC')
xlabel('Tiempo [s]')
ylabel('Voltaje [V]')


% Solución método numérico
[tm,xm]=ode45(odefun,[ti tf],[Vc0 pVc0]);
hold on
plot(tm,xm(:,1));
hold off