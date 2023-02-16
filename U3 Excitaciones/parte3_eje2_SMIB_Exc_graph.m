clear all
close all
clc

% Heffron phillips model 

S=555; % Potencia nominal del generador


xd=1.81; % reactancia en eje directo en pu

xpd=0.3; % reactancia transitoria en eje directo en pu
xq=1.76; % reactancia en eje cuadratura en pu
tpdo=8; % Tiempo transitorio
ra=0.003; % resistencia de Armadura
xl=0.16;
H=3.5; % Inercia
Kd=10; % Amortiguamiento
F=60; % frecuencia del sistema.



% Inductancias. 
Ladu=xd-xl;
Laqu=xq-xl;
Ksd=0.8491;Ksq=0.8491;
Xds=Ksd*Ladu+xl;
Xqs=Ksq*Laqu+xl;


% datos del generador. 
FP=0.9; % factor de potencia
P=0.9;
Q=0.3;

xe=0.65; % reactancia externa

Et=1; % voltaje en terminales.
Eb=0.995; % tensión en barra infinita.

tho= asin(P*xe/(Eb*Et));% angulo de desfase entre Eb y Et

%Estado de operación
Vto=Et*(cos(tho)+1i*sin(tho)); % tensión en terminales (compleja)
  
Ito=conj(P+1i*Q)/(conj(Vto)); % Corriente armadura (compleja)
fio=angle(Ito);% desfase 
it=abs(Ito); % Imax
di=atan((it*Xqs*cos(fio)-it*ra*sin(fio))/(Et+it*ra*cos(fio)+it*Xqs*sin(fio)))

edo=Et*sin(di);
eqo=Et*cos(di);

ido=it*sin(di+fio);
iqo=it*cos(di+fio);

EBd0=edo+xe*iqo;
EBq0=eqo-xe*ido;

EB=sqrt(EBq0^2+EBd0^2);

do=atan(EBd0/EBq0);

ifdo=(eqo+ra*iqo+Xds*ido)/(Ladu*Ksd);

efdo=Ladu*ifdo;



K1=(xq-xpd)/(xe+xpd)*iqo*Eb*sin(do)+eqo*Eb*cos(do)/(xe+xq);
K2=Eb*sin(do)/(xe+xpd);
K3=(xpd+xe)/(xd+xe);
K4=(xd-xpd)/(xe+xpd)*Eb*sin(do);
K5=xq/(xe+xq)*edo/Et*Eb*cos(do)-xpd/(xe+xpd)*eqo/Et*Eb*sin(do);

K6=xe/(xe+xpd)*eqo/Et;



T3=K3*tpdo;

% transductor
Tr=0.01;

% excitatriz
KA=10;
TA=0.1;
T1a=0;
T2a=0;
Tee=0.1;

parte3_eje1_SMIB_Exc
sim('parte3_eje1_SMIB_Exc')

% Función de transferencia de Lazo Abierto:
% sim('parte3_eje2_SMIB_Exc')
[A,B,C,D]=linmod('parte3_eje2_SMIB_Exc');
[Num,Den]=ss2tf(A,B,C,D);
sys_ol=tf(Num,Den)

% Bode
margin(sys_ol)


% funcion de transferencia lazo cerrado:

[A,B,C,D]=linmod('parte3_eje3_SMIB_Exc');
[Num,Den]=ss2tf(A,B,C,D);
sys_cl=tf(Num,Den)

figure
% Bode
bode(sys_cl)
grid on

% 
