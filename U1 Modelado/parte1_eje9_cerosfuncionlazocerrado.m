% parte1_eje9_cerosfuncionlazocerrado.m

wn=1; z=0.5;
% valores de Tp
vTz=[0 1 3 6 10];
for i=1:length(vTz)
    Tz=vTz(i);
    M=tf([wn^2*Tz wn^2],[1 2*z*wn wn^2]); %Lazo cerrado
   [x,t]=step(M,15);
    X{i}=x;
    T{i}=t;
end
figure; hold on;
plot(T{1},X{1},'b')
plot(T{2},X{2},'r')
plot(T{3},X{3},'y')
plot(T{4},X{4},'m')
plot(T{5},X{5},'k')
grid on; ylim([0 6])
title('Efecto de un cero en FT Lazo Cerrado')
ylabel('y(t)'); xlabel('Tiempo s')
legend('Tz=0','Tz=1','Tz=3','Tz=6','Tz=10')
