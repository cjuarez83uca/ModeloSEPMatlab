% parte1_eje9_zeroentrayectoriadirecta.m
wn=1;
z=0.5;

vTz=[0 0.2 0.5 2 5 10];
figure;
hold on;
for i=1:length(vTz)
    Tz=vTz(i);
    M=tf([wn^2*Tz wn^2],[1 2*z*wn+wn^2*Tz wn^2]);
    [y,t]=step(M,15);
    plot(t,y)
end
title('Efecto de un cero en Trayectoria directa')
ylabel('y(t)')
xlabel('Tiempo (s)')
legend('Tz=0','Tz=0.2','Tz=0.5','Tz=2','Tz=5','Tz=10')
