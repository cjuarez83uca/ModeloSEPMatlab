% circutoRLCFT.m
% circuto RLC - Serie

% Datos del sistema:
R= 100;
C= 0.1e-3;
L= 30;

% Función de transferencia
num=1/L/C;
den=[1 R/2/L 1/L/C];

sys=tf(num,den);
step(sys,5)
grid on


omega_n=sqrt(1/L/C);
rel_am=[0 0.1 0.5 1 2];

figure; hold on
for i=1:length(rel_am)
    R=4*rel_am(i)*L*omega_n;
    % Función de transferencia
    num=1/L/C;
    den=[1 R/2/L 1/L/C];
    
    sys=tf(num,den);
    step(sys,5)
    grid on
end
legend('z=0','z=0.1','z=0.5','z=1','z=2')

