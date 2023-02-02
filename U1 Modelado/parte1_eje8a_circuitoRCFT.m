% circuitoRCFT.m
% Constantes del circuitoRC
R=10;
C=0.01e-3;
tau=R*C;

% Funci�n de Transferencia
num=[1];
den=[tau 1];
sys=tf(num,den); % calcula una funci�n de transferencia
% respuesta al escal�n
step(sys);
grid on % grilla

% graficando l�nea recta pendiente 1/tau
hold on % mantener
t=0:tau/10:tau;
plot(t,(1/tau)*t,'r')


