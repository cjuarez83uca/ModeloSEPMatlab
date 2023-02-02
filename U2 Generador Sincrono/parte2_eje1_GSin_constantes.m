% Constantes del estator 
Ra=0.003;

% Constantes del rotor
Rfd=0.0006;
R1d=0.0284;
R1q=0.00619;
R2q=0.02368;

%constantes del Flujo de  enlace del estator
Lad=1.66;
Ll=0.15;

Laq=1.61;
L0=0.01;

% constantes del flujo de enlace del rotor
Lffd=0.165;
Lf1d=1.61;
L11d=0.1713;

L11q=0.7252;
L22q=0.125;


% Datos de entrada:

% Estado de operación
% S=1;
FP=0.9;
P=FP;
Q=sin(acos(FP));

Et=1;
It=1;
fi=acosd(FP);

% Valors de inductancia saturados
sat=0.833;
Lad=sat*Lad;
Laq=sat*Laq;

Ld=Lad+Ll;
Lq=Laq+Ll;

di=atand((Lq*It*cosd(fi)-Ra*It*sind(fi))/(Et+Ra*It*cosd(fi)+Lq*It*sind(fi)));
% entradas:
id=It*sind(di+fi);
iq=It*cosd(di+fi);
ifd=(Et*cosd(di)+Ra*iq+Ld*id)/Lad;
Im=1;
ws=1;%2*pi*60;
th=12*pi/180;

wr=1;


sim('parte2_eje1_GeneradorSincrono')