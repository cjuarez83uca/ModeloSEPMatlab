% parte1_ eje5_ft_circuitoRLC.m
% circuto RLC - Serie
% Datos del sistema:
R= 100; C= 0.1e-3; L= 30;
% condiciones iniciales
%      Son cero!
% Datos del tiempo
tsimu=10;
% formulación en representación en espacio de estado
Num=[1];
Den=[L*C R*C 1];
sim('parte1_eje5_ft_simu') % simulación en simulink
plot(salidas.Time,salidas.Data)
title('Voltaje del capacitor')
xlabel('Tiempo [s]')
ylabel('Voltaje [V]')


