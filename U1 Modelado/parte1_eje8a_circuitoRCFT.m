% circuitoRCFT.m
% Constantes del circuitoRC
R=10;
C=0.01e-3;
tau=R*C;

% Función de Transferencia
num=[1];
den=[tau 1];
sys=tf(num,den);
% respuesta al escalón
step(sys);
grid on % grilla
% graficando línea recta pendiente 1/tau
hold on
t=0:tau/10:tau;
plot(t,(1/tau)*t,'r')


