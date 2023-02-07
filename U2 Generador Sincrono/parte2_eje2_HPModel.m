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
H1=6.5;%constante de tiempo
KD=0;%amortiguamiento?
F=60;%frecuencia del sistema

% tension en barra infinita
eb=1;

% tension en terminales
vto=1.03;%%

% reactancia externa
xe=0.4;





tho=asin(P*xe/(eb*vto));%Ver ecuacion 12.70 (Kundur, pagina 729)corresponde a delta en dicha figura
Vto=vto*(cos(tho)+i*sin(tho));Ia=(P-i*Q)/(conj(Vto));ia=abs(Ia);fio=angle(Ia);
Eqo=Vto+(ra+xq*i)*Ia; eqo=abs(Eqo); do=angle(Eqo);
ido=-ia*sin(do-fio); iqo=ia*cos(do-fio);
efdo=eqo-(xd-xq)*ido; vqo=eb*cos(do)+ra*iqo-xe*ido; vdo=ra*iqo+xe*iqo-eb*sin(do);
wb=2*pi*F;
% Calculo de k1 a k6
k1=((xq-xpd)/(xe+xpd))*iqo*eb*sin(do)+eqo*eb*cos(do)/(xe+xq);
k2=eb*sin(do)/(xe+xpd);
k3=(xe+xpd)/(xd+xe);
k4=(xd-xpd)*sin(do)*eb/(xpd+xe);
k5=-(vdo/vto)*xq*eb*cos(do)/(xe+xq)-(vqo/vto)*xpd*eb*sin(do)/(xe+xpd);
k6=xe*(vqo/vto)/(xe+xpd);
k7=k2/k6;
T3=tpdo/(1+XTQ/D*(xd-xpd));
% Calculo de K1 a K6
K=[k1,k2,k3,k4,k5,k6,k7];
C=[H,F,tpdo,tho];