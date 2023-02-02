
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

FP=0.9; % factor de potencia

P=0.9;
Q=0.3;

xe=0.65; % reactancia externa

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
K7=K2/K6;


T3=K3*tpdo;