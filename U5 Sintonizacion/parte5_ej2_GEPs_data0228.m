% parte5_ej2_GEPs_data0228.m

% Datos del generador
d_kundur_4M2A

N_Gen=3;

% Datos del generador
xd=1.8;
xpd=0.3;
xq=1.7;
tpdo=8;
ra=0.0025;
xl=0.2;
H=6.175;
Kd=0;

K2=0.95567;
K3=0.34284;
K6=0.070874;
T3=tpdo*K3;

% datos del transductor
Tr=0.01;

% Excitación
Ke=1;
Te=0.01;

% AVR
Ka=200;
T1a=0;
T2a=0.1;


% función de transferencia GEPs
sys=linmod('parte5_ej2_GEPs_0228')

% autovalores
eig(sys.a)


clear all
close all

% agregar directio de psat
addpath('psat')

% iniciando psat
initpsat
% cargar datos
runpsat('d_kundur_4M2A','data')
% correr flujo de potencia
runpsat('pf')

% Análisis modal
% Matriz de estado
A=DAE.Fx-DAE.Fy*inv(DAE.Gy)*DAE.Gx;


% Autovalores, autovectores
[Vo,auto]=eig(full(A));
lo=diag(auto);

% frecuencias de interés
% finterarea 0.2Hz hasta 1Hz; flocales 1Hz hasta 2Hz








