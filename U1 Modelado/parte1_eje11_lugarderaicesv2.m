% Lugar de las raíces.

wn=1;
z=1;
numG=[wn^2];
denG=[1 2*z*wn 0];
Gs=tf(numG,denG)
rlocus(Gs)
k=3;
M=tf([k*wn^2],[1 2*z*wn k*wn^2])
figure
step(M)