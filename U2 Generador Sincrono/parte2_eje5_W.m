clear all % borra todas las variables
close all % cierra todas las ventanas.
% parte2_eje5_W
Ld=1.5; %reactancia en eje directo pu
Lq=1; % reactancia en eje cuadratura

Tpdo=8;% tiempo transitorio.
Lpd=0.3; % reactancia transitoria eje directo
L2pd=0.05;% reactancia subransitoria
T2pdo=0.05; % tiempo subtransitorio



T2pqo=T2pdo;
L2pq=L2pd;
%GENSAL
num1=[Tpdo*Lpd/Ld  1];
num2=[T2pdo*L2pd/Lpd 1];
den1=[Tpdo 1];
den2=[T2pdo 1];

% multiplicación  

Num=conv(num1,num2);
Num=Ld*Num;
Den=conv(den1,den2);
% tf, zpk, step son funciones del toolbox de control
Wd_gensal=tf(Num,Den) % funcion de transferencia Wd
Wd_gensalzpk=zpk(Wd_gensal) % expresión en zeros, polos y ganancia

%respuesta al escalón
figure(1)
step(Wd_gensal)
title('Wd GENSAL')
xlabel('tiempo')
ylabel('W')

num1=[L2pq/Lq*T2pqo 1];
den1=[T2pqo 1];
Wq_gensal=tf(num1,den1)
Wq_gensalzpk=zpk(Wq_gensal)

figure(1)
hold on
step(Wq_gensal)








