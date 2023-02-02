% ------------- Respuesta a un escalón unitario ----------- --
num = [25];
den = [1 4 25];
h=0.01;
t = 0:0.01:4;
[y,x,t] = step(num,den,t);
plot(t,y)
grid
title ('Respuesta a un escalón unitario de G(s)=25/(s^2+4s+25)')
xlabel('tiempo [s]')
ylabel('Salida')

% tiempo de subida
[y,x,t]=step(num,den,t);
r=1;
while y(r)<1.0001
    r=r+1;
end
tiempo_subida=(r - 1)*h;
% Tiempo pico y sobreenlongación
[ymax,idx_tp]=max(y);
tiempo_pico=(idx_tp - 1)*h;
sobreelongacion_max=ymax-1;

% tiempo de establecimiento
s=length(t); 
while y(s)>0.98 && y(s)<1.02 % dos porciento
    s=s-1;
end
tiempo_asentamiento=(s-1)*h;

fprintf('tiempo de subida= %6.4f\n',tiempo_subida)
fprintf('tiempo pico= %6.4f\n',tiempo_pico)
fprintf('sobreenlongación máxima= %6.4f\n',sobreelongacion_max)
fprintf('tiempo de establecimiento= %6.4f\n',tiempo_asentamiento)