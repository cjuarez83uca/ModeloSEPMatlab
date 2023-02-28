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

Et=1; % voltaje en terminales.
Eb=0.995; % tensión en barra infinita.

tho= asin(P*xe/(Eb*Et));% angulo de desfase entre Eb y Et

%Estado de operación
Vto=Et*(cos(tho)+1i*sin(tho)); % tensión en terminales (compleja)

Ia=(P-1i*Q)/(conj(Vto)); % Corriente armadura (compleja)
ia=abs(Ia); % Imax
fio=angle(Ia);% desfase

Eqo=Vto+(ra+xq*1i)*Ia; % tensión en cudratura del generador.
eqo=abs(Eqo); % eq
do=angle(Eqo); % desfase

ido=-ia*sin(do-fio);  % id
iqo=ia*cos(do-fio); % iq

efdo=eqo-(xd-xq)*ido; % tensión de campo

vqo=Eb*cos(do)+ra*iqo-xe*ido; %vq terminales
vdo=ra*iqo+xe*iqo-Eb*sin(do); %vd terminales

wb=2*pi*F; % frecuencia base.

% Calculo de k1 a k6
RT=ra;
XTQ=xe+xq;
XTD=xe+xpd;
D=RT^2+XTQ*XTD;
Ksat=0.83;
Ladu=xd-xl;
Laqu=xq-xl;
Lads=Ksat*Ladu;
Laqs=Ksat*Laqu;
Lfd= ((xpd-xl)*Ladu)/(Ladu-(xpd-xl));
Ks=(Eb*Eqo)/(xd+xe)*cos(tho);
K1=Eb*eqo/D*(RT*sin(do)+XTD*cos(do))+Eb*iqo/D*(xq-xpd)*(XTQ*sin(do)-RT*cos(do));
K2=Lads/(Lads+Lfd)*(RT/D*eqo+(XTQ*(xq-xpd)/D+1)*iqo);


K3=(Lads+Lfd)/Ladu*1/(1+XTQ/D*(xd+xpd));
K4=Eb/D*(xd-xpd)*(XTQ*sin(do)-RT*cos(do));
K5=-(vdo/Et)*xq*Eb*cos(do)/(xe+xq)-(vqo/Et)*xpd*Eb*sin(do)/(xe+xpd);
K6=xe*(vqo/Et)/(xe+xpd);



T3=K3*tpdo;




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
T1=0.3;
T2=0.03;
T3=0.3;
T4=0.03;

% Función de transferencia del compensador
sysPSS=tf([T1 1],[T2 1])*tf([T3 1],[T4 1]);

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





