clear all;
close all;

% Wykresy - grupa nr 1 (inercja 2-rzędu)

opis1 = ['T2 = 0    ';'T2 = T1/10';'T2 = T1/2 ';'T2 = T1   '];
s = tf('s');
t = 0:10:650;
T1 = 100;
K = 15;
kT2 = [0,0.1,0.5,1];
for i=1:size(kT2,2)
    T2 = kT2(i)*T1;
    Trs = K/((T1*s+1)*(T2*s+1));
    if i == 3
        figure(9);
        step(Trs,t);
        hold on;
    end
    if i == 1
        figure(10);
        bode(Trs);
        hold on;
    end
    figure(1);
    step(Trs,t);
    hold on;
    figure(2);
    bode(Trs,{10^(-5),10^(4)});
    hold on;
end
figure(1); title('Wykresy grupa nr 1 (inercja 2-rzędu) - ch. czasowe'); legend(opis1);
figure(2); title('Wykresy grupa nr 1 (inercja 2-rzędu) - ch. częstotliwościowe'); legend(opis1);

% Wykresy - grupa nr 2 (całkowanie)

opis2 = ['T2 = 0     ';'T2 = T1/100';'T2 = T1/10 ';'T2 = T1    ';'T2 = 10T1  '];
t = 0:5:150;
Ti = 100;
K = 15;
kT2 = [0,0.01,0.1,1,10];
for i=1:size(kT2,2)
    T2 = kT2(i)*Ti;
    Trs = K/((Ti*s)*(T2*s+1));
    figure(3);
    step(Trs,t);
    hold on;
    figure(4);
    bode(Trs);
    hold on;
end
figure(3); title('Wykresy grupa nr 2 (całkowanie) - ch. czasowe'); legend(opis2);
figure(4); title('Wykresy grupa nr 2 (całkowanie) - ch. częstotliwościowe'); legend(opis2);

% Wykresy - grupa nr 3 (różniczkowanie)

opis3 = ['Idealny człon różn.'];
opis4 = ['T2 = Td/100';'T2 = Td/10 ';'T2 = Td    ';'T2 = 10Td  '];
t = 0:0.05:2.5;
Td = 100;
K = 15;
kT2 = [0.00001,0.01,0.1,1,10];
for i=1:size(kT2,2)
    T2 = kT2(i)*Td;
    Trs = Td*s/(T2*s+1);
    if i == 1
        figure(5);
        step(Trs,t); 
        hold on;
        figure(6);
        bode(Trs); 
        hold on;
    else
        figure(7);
        step(Trs,t);
        hold on;
        figure(8);
        bode(Trs);
        hold on;
    end
end
figure(5); title('Idealny człon różniczkujący - ch. czasowa'); legend(opis3);
figure(6); title('Idealny człon różniczkujący - ch. częstotliwościowa'); legend(opis3);
figure(7); title('Wykresy grupa nr 3 (różniczkowanie) - ch. czasowe'); legend(opis4);
figure(8); title('Wykresy grupa nr 4 (różniczkowanie) - ch. częstotliwościowa'); legend(opis4);

% Model przybliżony dla wykresu charakterystyki czasowej (inercja 2-rzędu)

opis5 = ['Model dokładny   ';'Model przybliżony'];
model = 'sim01';
dt = 1;
T0 = 30;
T = 160;
k = 15;
L = k;
M = [T,1];
figure(9);
sim(model,1000);
plot(ans.tout,ans.simout,'r');
title('Model dokładny (inercja 2-rzędu) i jego przybliżenie'); legend(opis5);