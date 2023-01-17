% parte1_eje10_polosdominantes.m

%Sea FT
% G(s)= 20/(s+10)(s^2+2s+2);

p1=[1 10]; % primer polinomio
p2=[1 2 2]; % segundo polinomio

den=conv(p1,p2); % multiplicacion de polinomios
num=20;
G=tf(num,den); % creando función de transferencia 
% Respuesta al escalón
[x1,t1]=step(G,10);

plot(t1,x1)


% Eliminando cero
G1=tf(20,p2); % creando función de transferencia 
% Respuesta al escalón
[x2,t2]=step(G1,10);
hold on
plot(t2,x2)

title('respuesta al escalón - no respuesta estable')
xlabel('tiempo [s]')
ylabel('y(t)')

legend('original','eliminado s+10')
hold off

%  considerando estado estable
G2=tf(20,10*p2); % creando función de transferencia 
% Respuesta al escalón
[x3,t3]=step(G2,10);

figure;
plot(t1,x1);
hold on;
plot(t3,x3);
hold off
title('respuesta al escalón - si respuesta estable')
xlabel('tiempo [s]')
ylabel('y(t)')

legend('original','eliminado polo')

