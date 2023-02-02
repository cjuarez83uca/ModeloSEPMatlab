% parte1_eje1_circuitoRC.m
% Este programa simula un sistema RC sin fuentes.

% Datos físicos (Parámetros)
R = 10; % ohms
C = 1e-3; %faradios
tau=R*C;


% EDO orden 1 --> 1 Condiciones iniciales 
Vo=1; % volt

% discretización de la variable independiente
% tiempo
h=1e-3; % paso de tiempo.
tfinal=5*tau; % tiempo simulación.
t=0:h:tfinal;

% Tensión del capacitor
% Valor teórico
Vteorico=Vo*exp(-t/(R*C));

%Gráfica de la tensión teórica.
figure
plot(t,Vteorico,'b')
title('Comportamiento de la tensión en sistema RC sin fuentes')
xlabel('Tiempo (s)')
ylabel('Tensión (v)')



% simulación numérica
% inicialización variable salida.
Vaprox=zeros(1,length(t));

% Condición inicial t=0;
Vaprox(1)=Vo;

for i=1:length(t)-1
    Vaprox(i+1)=Vaprox(i)+h*(-1/(R*C)*Vaprox(i));
end

hold on % para mantener la gráfica anterior.
plot(t,Vaprox,'r')

legend('Valor téorica','Valor aproximado')




