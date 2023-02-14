% Calculo condiciones iniciales
% datos de la maquina xd, xpd, xq, tpdo, 
% ra: resistencia de armadura, 
% eb= tension en pu en barra infinita
% H= constante de inercia
% F= fcia en Hz, 
% P, Q estado de carga, 
% xe: reactancia externa, 
% vto: tensi´on en terminales pu [0.95;1.;1.05]
% D: amortiguamiento en =0
P=0.9;
Q=0.3;

xd=1.8;%reactancia de eje directo
xpd=0.3;%reactancia transitoria de eje directo
xq=1.7;%reactancia de eje en cuadratura
tpdo=8.0;%constante de tiempo de eje de cuadratura en eje directo
ra=0.003;%resistencia de armadura
H=6.5;%constante de tiempo
KD=0;%amortiguamiento?
F=60;%frecuencia del sistema

% tension en barra infinita
eb=1;

% tension en terminales
vto=1.03;%%

% reactancia externa
xe=0.4;



% Página 727

tho=asin(P*xe/(eb*vto));%Ver ecuacion 12.70 (Kundur, pagina 729)corresponde a delta en dicha figura
Vto=vto*(cos(tho)+i*sin(tho));
Ia=(P-i*Q)/(conj(Vto));
ia=abs(Ia);
fio=angle(Ia);

Eqo=Vto+(ra+xq*i)*Ia; 
eqo=abs(Eqo); 
do=angle(Eqo);

ido=-ia*sin(do-fio);
iqo=ia*cos(do-fio);


efdo=eqo-(xd-xq)*ido;
vqo=eb*cos(do)+ra*iqo-xe*ido; 
vdo=ra*iqo+xe*iqo-eb*sin(do);

w0=2*pi*F;
% Calculo de k1 a k6
K1=((xq-xpd)/(xe+xpd))*iqo*eb*sin(do)+eqo*eb*cos(do)/(xe+xq);
K2=eb*sin(do)/(xe+xpd);
K3=(xe+xpd)/(xd+xe);
K4=(xd-xpd)*sin(do)*eb/(xpd+xe);
K5=-(vdo/vto)*xq*eb*cos(do)/(xe+xq)-(vqo/vto)*xpd*eb*sin(do)/(xe+xpd);
K6=xe*(vqo/vto)/(xe+xpd);
T3=tpdo/(1+(xe+xpd)/(ra^2+xe^2*(xpd+xq))*(xd-xpd));
KS=eb*eqo/(xpd+xe)*cos(do);


% Análisis Modelo Clásico
sysclas=linmod('parte2_ej2_GBClasico');

lclasico=eig(sysclas.a)

% Análisis Modelo Circuito Campo
sys_fd=linmod('parte2_ej2_GBHP');

lfd=eig(sys_fd.a)


%Análisis de Modelo con excitación
TR=0.01;
KA=50;
sys_ex=linmod('parte2_ej2_GBHPEx');

lex=eig(sys_ex.a)


