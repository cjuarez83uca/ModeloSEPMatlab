% Constantes del circuitoRC
R=10;
C=0.01e-3;
tau=R*C;

% condiciones iniciales
Vo=1;

% discretización del tiempo
h=0.05e-4;
t=0:h:5*tau;

% cálculo del V capacitor (teoría)
Vc=Vo*exp(-t/tau);

% graficando
plot(t,Vc)
title('Comportamiento del voltaje del Capacitor')
xlabel('tiempo [s]')
ylabel('voltaje [V]')

% Inicializando variables
Vaprox=zeros(length(t),1);

% condiciones iniciales
Vaprox(1)=Vo;

% solucionando por métodos numéricos
for i=1:length(t)-1
    Vaprox(i+1)=Vaprox(i)+h*(-1/R/C*Vaprox(i));
end
hold on % mantiene lo graficado
plot(t,Vaprox);
hold off % ya no mantiene lo graficado.



