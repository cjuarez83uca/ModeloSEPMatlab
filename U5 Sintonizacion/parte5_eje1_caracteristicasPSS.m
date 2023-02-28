% Filtro Washout
% Filtro Washout
close all
Twt=[2 10];
for i=1:length(Twt)
    Tw=Twt(i);
    Filt_washout=tf([Tw 0],[Tw 1]);
    figure(1)
    hold on
    step(Filt_washout);
    title(['Filtro Washout a respuesta a u(t)'])
    hold off
    legenda{i}=['Tw= ' num2str(Tw)];
    figure(2)
    hold on
    bode(Filt_washout);
    title(['Filtro Washout - Diagrama de Bode'])
    grid on
    hold off
end
figure(1)
legend(legenda)
figure(2)
legend(legenda)

% Compensación
T1=0.3;
T2=0.03;
T3=0.3; 
T4=0.03;


comp1=tf([T1 1],[T2 1]);
comp2=tf([T3 1],[T4 1]);

compt=comp1*comp2;

figure(3)
subplot(2,1,1)
step(comp1)
title('compensador 1 - respuesta a u(t)')
subplot(2,1,2);
step(compt)
title('compensador 1 y 2 - respuesta a u(t)')

figure(4)

[Mag_comp1,Pha_comp1,w_comp1]=bode(comp1);
subplot(2,2,1)
semilogx(w_comp1,Mag_comp1(:))
xlim([w_comp1(1) w_comp1(end)])
ylim([min(Mag_comp1(:)) max(Mag_comp1(:))])
title('Magnitud - Compensador 1')
grid on
subplot(2,2,3)
semilogx(w_comp1,Pha_comp1(:))
xlim([w_comp1(1) w_comp1(end)])
ylim([min(Pha_comp1(:)) max(Pha_comp1(:))])
grid on
title('Fase - Compensador 1')

[Mag_compt,Pha_compt,w_compt]=bode(compt);
subplot(2,2,2)
semilogx(w_compt,Mag_compt(:))
xlim([w_compt(1) w_compt(end)])
ylim([min(Mag_compt(:)) max(Mag_compt(:))])
title('Magnitud - Compensador total')
grid on
subplot(2,2,4)
semilogx(w_compt,Pha_compt(:))
xlim([w_compt(1) w_compt(end)])
ylim([min(Pha_compt(:)) max(Pha_compt(:))])
grid on
title('Fase - Compensador total')





