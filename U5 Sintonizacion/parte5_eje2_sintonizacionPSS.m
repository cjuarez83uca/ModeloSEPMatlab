% sintonización de PSS
% Modelo del sistema

% usando PSAT
addpath('psat')

file=pwd;

initpsat
runpsat('d_kundur_4M2A','data')
runpsat('pf')

% análisis Modal

%% ANALISIS MODAL
%--------------- State Matrix --------------------------------
% from DAE analysis!
A=DAE.Fx-DAE.Fy*inv(DAE.Gy)*DAE.Gx;

%---------Eigenvalues, Eigenvectors and participation factors -------------
[Vo,auto1]=eig(full(A));% obtengo los auto valores y autovectores derecho del ODE
lo=diag(auto1);% lo guarda los autovalores
dampor=-100*real(lo)./sqrt(real(lo).^2+imag(lo).^2);
freqor=imag(lo)/2/pi;
Wo = pinv(Vo); % genera autovector izquierdo del ODE
WtV = sum(abs(Vo).*abs(Wo.'));
pf = [abs(Vo).*abs(Wo.')];
for i = 1:length(lo), pf(:,i) = pf(:,i)/WtV(i); end

mx_idx=find(freqor>0.4 & freqor<1.5 & dampor<50);
damp=dampor(mx_idx);
freq=freqor(mx_idx);
idx_modocrt=mx_idx; % indexes of critical modes
sal=[idx_modocrt damp freq  real(lo(idx_modocrt)) imag(lo(idx_modocrt))]
if 0
    % modo local 1
    figure
    compass(Vo(Syn.omega(1),mx_idx(1)),'r')
    hold on
    compass(Vo(Syn.omega(2),mx_idx(1)),'b')
    compass(Vo(Syn.omega(3),mx_idx(1)),'g')
    compass(Vo(Syn.omega(4),mx_idx(1)),'m')
    legend('G1','G2','G3','G4')
    
    figure
    bar(pf(Syn.omega,mx_idx(1)))
    
    
    % modo local 2
    figure
    compass(Vo(Syn.omega(4),mx_idx(2)),'m')
    hold on
    compass(Vo(Syn.omega(1),mx_idx(2)),'r')
    compass(Vo(Syn.omega(2),mx_idx(2)),'b')
    compass(Vo(Syn.omega(3),mx_idx(2)),'g')
    legend('G4','G1','G2','G3')
    figure
    bar(pf(Syn.omega,mx_idx(2)))
    
    
    % Interárea
    figure
    compass(Vo(Syn.omega(3),mx_idx(3)),'g')
    
    hold on
      compass(Vo(Syn.omega(4),mx_idx(3)),'m')
    compass(Vo(Syn.omega(1),mx_idx(3)),'r')
    compass(Vo(Syn.omega(2),mx_idx(3)),'b')
  
    legend('G3','G4','G1','G2')
    title('modo interárea')
    figure
    bar(pf(Syn.omega,mx_idx(3)))
        title('modo interárea')
end

% % análisis en el tiempo
if 0
    runpsat('td')
    figure
    plot(Varout.t,Varout.vars(:,Syn.omega))
    legend('G1','G2','G3','G4')
    xlabel('Tiempo')
    ylabel('velocidad')
end
%% MODELO UNA MÁQUINA BARRA INFINITA
% % Heffron phillips model
d_kundur_4M2A

% MÁQUINA A DONDE COLOCAREMOS PSS
N_Gen=3;

% DATOS DEL GENERADOR
S= Syn.con(N_Gen,2); % Potencia nominal del generador
xd=Syn.con(N_Gen,8); % reactancia en eje directo en pu
xpd=Syn.con(N_Gen,9); % reactancia transitoria en eje directo en pu
xq=Syn.con(N_Gen,13); % reactancia en eje cuadratura en pu
tpdo=Syn.con(N_Gen,11); % Tiempo transitorio
ra=Syn.con(N_Gen,7); % resistencia de Armadura
xl=Syn.con(N_Gen,6); % REACTANCIA
H=Syn.con(N_Gen,18)/2; % Inercia
Kd=Syn.con(N_Gen,19); % Amortiguamiento

% DATOS DE LA EXCITACIÓN
% transductor
Tr=0.01;

% excitatriz
KA=200;
TA=0.1;
T1e=1;
T2e=1;
Tee=0.01;

% DATOS DE OPERACIÓN DE LA MÁQUINA.
F=60; % frecuencia del sistema.


P=Bus.Pg(N_Gen);
Q=Bus.Qg(N_Gen);

xe=1; % reactancia externa

vto=1.03; % voltaje en terminales.
eb=1; % tensión en barra infinita.

tho=asin(P*xe/(eb*vto));%Ver ecuacion 12.70 (Kundur, pagina 729)corresponde a delta en dicha figura
Vto=vto*(cos(tho)+i*sin(tho));Ia=(P-i*Q)/(conj(Vto));ia=abs(Ia);fio=angle(Ia);
Eqo=Vto+(ra+xq*i)*Ia; eqo=abs(Eqo); do=angle(Eqo);
ido=-ia*sin(do-fio); iqo=ia*cos(do-fio);
efdo=eqo-(xd-xq)*ido; vqo=eb*cos(do)+ra*iqo-xe*ido; vdo=ra*iqo+xe*iqo-eb*sin(do);%Tiene signos cambiados respecto a la formula del Kundur (Pagina 747)
%Por eso el signo en k5 tambien se modifica respecto al del paper concepts
%of Synchronous Machine Stability as affected by Excitation Control
wb=2*pi*F;
% Calculo de k1 a k6
K1=((xq-xpd)/(xe+xpd))*iqo*eb*sin(do)+eqo*eb*cos(do)/(xe+xq);
K2=eb*sin(do)/(xe+xpd);
K3=(xe+xpd)/(xd+xe);
K4=(xd-xpd)*sin(do)*eb/(xpd+xe);
K5=-(vdo/vto)*xq*eb*cos(do)/(xe+xq)-(vqo/vto)*xpd*eb*sin(do)/(xe+xpd);
K6=xe*(vqo/vto)/(xe+xpd);
T3=tpdo*K3;



% SINTONIZACIÓN DEL PSS
finteres=freqor(mx_idx(3));

% Cálculo de los márgenes de fase
[A,B,C,D]=linmod('parte5_eje2_GEPs');
sysGEP=ss(A,B,C,D);

% bode de lazo abierto
bode(sysGEP);
title('Bode de lazo abierto GEP')
grid on

w_int=2*pi*finteres;
[mag_int,fase_int]=bode(sysGEP,w_int);

w_loc=2*pi*freqor(mx_idx(2));
[mag_loc,fase_loc]=bode(sysGEP,w_loc);

% Compensadores
T1pss=0.3;
T2pss=0.03;
T3pss=0.3;
T4pss=0.03;

% Función de transferencia del compensador
sysPSS=tf([T1pss 1],[T2pss 1])*tf([T3pss 1],[T4pss 1]);

% Función GPSSGEP
sys=sysGEP*sysPSS;
hold on
bode(sys)
[mag_loc,fase_loc]=bode(sys,w_loc);
[mag_int,fase_int]=bode(sys,w_int);


% % Ganancia 
[A,B,C,D]=linmod('parte5_eje2_SMIB_Exc_PSS');
sys_pss=ss(A,B,C,D);
sys_pss=tf(sys_pss);
figure
rlocus(sys_pss)





