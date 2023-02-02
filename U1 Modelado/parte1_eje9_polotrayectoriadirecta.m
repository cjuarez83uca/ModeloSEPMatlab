% parte1_eje9_polotrayectoriadirecta
%
% Datos de G(s)
wn=1;
z=1;
% Funci�n de transferencia de G(s)
num=wn^2;
den=[1 2*z*wn 0];
Gs=tf(num,den)

% Funci�n de transferencia de lazo cerrado
vTp=[0 0.5 1 2 5];
figure;
hold on;% mantener las gr�ficas anteriores
for i=1:length(vTp)
    Tp=vTp(i);
    numM=wn^2;
    denM=[Tp 1+2*z*wn*Tp 2*z*wn wn^2];
    
    M=tf(numM,denM);
    [y,t]=step(M,20);
    plot(t,y)
end
grid on
title('Efecto de un polo en FT Directa')
ylabel('y(t)')
xlabel('Tiempo (s)')
legend('Tp=0','Tp=0.5','Tp=1','Tp=2','Tp=5')

