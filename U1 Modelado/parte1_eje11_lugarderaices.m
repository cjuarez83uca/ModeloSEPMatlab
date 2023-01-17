% parte1_eje10_lugarderaices.m
close all

K=1;
Gc=tf([1 0.2],conv([1 0.4],[1 0.4]));
Gp=tf([1 1],conv([1 0],conv([1 40],[1 40])));

G=Gc*Gp*K;
M=G/(1+G);
figure(1)
step(M)
title('Respuesta escalón lazo cerrado con K=1')

figure(2)
rlocus(G)



K=2.55e3;
G1=Gc*Gp*K;
M=G1/(1+G1);
figure(3)
step(M)
title('Respuesta escalón lazo cerrado con K=2.55e3')
R=rlocus(G,K)

K=1.26e5;
G2=Gc*Gp*K;
M=G2/(1+G2);
figure(4)
step(M)
title('Respuesta escalón lazo cerrado con K=1.26e5')
R=rlocus(G,K)