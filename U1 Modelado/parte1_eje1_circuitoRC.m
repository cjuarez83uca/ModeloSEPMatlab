% parte1_eje1_circuitoRC.m
% Este programa simula un sistema RC sin fuentes.

% Datos f�sicos (Par�metros)
R = 10; % ohms
C = 1e-3; %faradios
tau=R*C;


% EDO orden 1 --> 1 Condiciones iniciales 
Vo=1; % volt

% discretizaci�n de la variable independiente
% tiempo
h=1e-3; % paso de tiempo.
tfinal=5*tau; % tiempo simulaci�n.
t=0:h:tfinal;

% Tensi�n del capacitor
% Valor te�rico
Vteorico=Vo*exp(-t/(R*C));

%Gr�fica de la tensi�n te�rica.
figure
plot(t,Vteorico,'b')
title('Comportamiento de la tensi�n en sistema RC sin fuentes')
xlabel('Tiempo (s)')
ylabel('Tensi�n (v)')



% simulaci�n num�rica
% inicializaci�n variable salida.
Vaprox=zeros(1,length(t));

% Condici�n inicial t=0;
Vaprox(1)=Vo;

for i=1:length(t)-1
    Vaprox(i+1)=Vaprox(i)+h*(-1/(R*C)*Vaprox(i));
end

hold on % para mantener la gr�fica anterior.
plot(t,Vaprox,'r')

legend('Valor t�orica','Valor aproximado')




