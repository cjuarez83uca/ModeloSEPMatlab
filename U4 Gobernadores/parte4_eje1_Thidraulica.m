% Función de transferencia turbina hidráulica
clear all
close all
% Para un turbina Francis con Tw = 4;
Tw=4;
Gw=tf([-Tw 1],[0.5*Tw 1]);
step(Gw)

title('Respuesta al escalón Turbina hidráulica Tw=4')

hold on; plot([0 2],[-2 1],'r')
plot([2 2],[-2 1.1],'-.k')
text(0.2,0.8,'Tw/2')