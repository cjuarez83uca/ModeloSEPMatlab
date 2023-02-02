% parte1_eje9_polosagregadosallazocerrado.m
wn=1;
z=0.5;

vTp=[0 0.5 1 2 4];
M=tf(wn^2,[1 2*z/wn wn^2]);
for i=1:length(vTp)
    Tp=vTp(i);
    Ex=tf(1,[Tp 1]);
    H=M*Ex;
    [y,t]=step(H,15);
    Y{i}=y;
    T{i}=t;
end
figure;
hold on;
plot(T{1},Y{1},'b')
plot(T{2},Y{2},'r')
plot(T{3},Y{3},'k')
plot(T{4},Y{4},'g')
plot(T{5},Y{5},'c')
grid on;
title('Efecto de agregar polo a FT lazo cerrado')
ylabel('y2(t)')
xlabel('Tiempo (s)')
legend('Tp=0','Tp=0.5','Tp=1','Tp=2','Tp=4')


