% parte5_ej1_PSS_0228.m

% Filtro washout
% Filtro pasa altas

Tw=10;
sys=tf([Tw 0],[Tw 1]);


bode(sys)

Tw=3.5;
sys=tf([Tw 0],[Tw 1]);
hold on
bode(sys)

legend('Tw=10','Tw=3.5')


% Compensador - Adelanto (T1>T2)
T1=1;
T2=0.5;

sys=tf([T1 1],[T2 1]);
figure
bode(sys)

% Compensador - Atraso (T3<T4)
T3=0.5;
T4=1;

sys=tf([T3 1],[T4 1]);
figure
bode(sys)


