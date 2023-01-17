% parte1_eje9_poloscerosextra.m
close all
% CASO 1 un polo en la función de tranferencia directa
wn=1;
z=1;

% valores de Tp
vTp=[0 1 2 5];

for i=1:length(vTp)
    Tp=vTp(i);
    M=tf([wn^2],[Tp (1+2*z*wn*Tp) 2*z*wn wn^2]);
    [x,t]=step(M,20);
    X{i}=x;
    T{i}=t;
end
figure;
hold on;
plot(T{1},X{1},'b')
plot(T{2},X{2},'r')
plot(T{3},X{3},'y')
plot(T{4},X{4},'m')

ylim([0 2])
grid on
title('Efecto de un polo en FT Directa')
ylabel('y(t)')
xlabel('Tiempo s')

text(0.0,0.6,'Tp = 0')
text(2.5,1.1,'Tp = 1')
text(6,1.35,'Tp = 2')
text(10,1.6,'Tp = 5')


% CASO 2 un polo en la función de lazo cerrado

wn=1;
z=0.5;

% valores de Tp
vTp=[0 0.5 1 2 4];

for i=1:length(vTp)
    Tp=vTp(i);
    M=tf([wn^2],[1 2*z*wn wn^2]); %Lazo cerrado
    Ex=tf([1],[Tp 1]); % polo extra
    H=M*Ex; % función total
    [x,t]=step(H,15);
    X{i}=x;
    T{i}=t;
end
figure;
hold on;
plot(T{1},X{1},'b')
plot(T{2},X{2},'r')
plot(T{3},X{3},'y')
plot(T{4},X{4},'m')
plot(T{5},X{5},'k')
grid on
ylim([0 1.2])

title('Efecto de un polo en FT Lazo Cerrado')
ylabel('y(t)')
xlabel('Tiempo s')

legend('Tp=0','Tp=0.5','Tp=1','Tp=2','Tp=4')


%CASO 3 UN CERO EN LA FUNCIÓN TRANSFERENCIA DE TRAYECTORIA DIRECTA
wn=1; z=1;
vTz=[0 0.2 0.5 2 5 10];
for i=1:length(vTz)
    Tz=vTz(i);
    G=tf([wn^2*Tz wn^2],[1 2*z*wn 0]); M=G/(1+G);
    [x,t]=step(M,15);
    X{i}=x; T{i}=t;
end
figure; hold on;
plot(T{1},X{1},'b'); plot(T{2},X{2},'r')
plot(T{3},X{3},'y'); plot(T{4},X{4},'m')
plot(T{5},X{5},'k'); plot(T{6},X{6},'c')
grid on; ylim([0 1.2])
title('Efecto de un cero en FT Lazo abierto')
ylabel('y(t)'); xlabel('Tiempo s')
legend('Tz=0','Tz=0.2','Tz=0.5','Tz=2','Tz=5','Tz=10','location','best')

% CASO 4 UN CERO EN LA FUNCIÓN DE TRANSFERENCIA DE LAZO CERRADO
wn=1; z=0.5;
% valores de Tp
vTz=[0 1 3 6 10];
for i=1:length(vTz)
    Tz=vTz(i);
    M=tf([wn^2*Tz wn^2],[1 2*z*wn wn^2]); %Lazo cerrado
   [x,t]=step(M,15);
    X{i}=x;
    T{i}=t;
end
figure; hold on;
plot(T{1},X{1},'b')
plot(T{2},X{2},'r')
plot(T{3},X{3},'y')
plot(T{4},X{4},'m')
plot(T{5},X{5},'k')
grid on; ylim([0 6])
title('Efecto de un cero en FT Lazo Cerrado')
ylabel('y(t)'); xlabel('Tiempo s')
legend('Tz=0','Tz=1','Tz=3','Tz=6','Tz=10')