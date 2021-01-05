clear all;
close all;


% Laboratorium 06-08 - deklaracje danych dla wykresów


kolor_dokl = ['r';'b';'g'];
kolor_zlin = ['r--';'b--';'g--'];
kolor_rs = ['rx';'bx';'gx'];
kolor_trs = ['ro';'bo';'go'];
kolor_zlin2 = ['rx';'bo';'g+'];
opis1 = ['0% fwe1max -> dokł. ';'50% fwe1max -> dokł.';'90% fwe1max -> dokł.'; '0% fwe1max -> zlin. '; '50% fwe1max -> zlin.'; '90% fwe1max -> zlin.'];
opis2 = ['0% fwe1max -> zlin. ';'50% fwe1max -> zlin.';'90% fwe1max -> zlin.'; '0% fwe1max -> rs.   '; '50% fwe1max -> rs.  '; '90% fwe1max -> rs.  ';'0% fwe1max -> trs.  '; '50% fwe1max -> trs. '; '90% fwe1max -> trs. '];
opis3 = ['0% fwe1max -> zlin. ';'0% fwe1max -> rs.   ';'0% fwe1max -> trs.  '];
fig1 = figure(1), hold on, grid on;
xlabel('Czas [s]');
ylabel('Poziom h1 [m]');
title('Zbiornik nr 1 - skok fwe1');
fig2 = figure(2), hold on, grid on;
xlabel('Czas [s]');
ylabel('Poziom h2 [m]');
title('Zbiornik nr 2 - skok fwe1');
fig3 = figure(3), hold on, grid on;
xlabel('Czas [s]');
ylabel('Poziom h1 [m]');
title('Zbiornik nr 1 - skok fwe1');
fig4 = figure(4), hold on, grid on;
xlabel('Czas [s]');
ylabel('Poziom h2 [m]');
title('Zbiornik nr 2 - skok fwe1');
fig5 = figure(5), hold on, grid on;
xlabel('Czas [s]');
ylabel('Przyrost h1 [m]');
title('Zbiornik nr 1 - skok fwe1');
fig6 = figure(6), hold on, grid on;
xlabel('Czas [s]');
ylabel('Przyrost h2 [m]');
title('Zbiornik nr 2 - skok fwe1');
fig7 = figure(7), hold on, grid on;
xlabel('Czas [s]');
ylabel('Poziom h1 [m]');
title('Zbiornik nr 1 - skok fwe2');
fig8 = figure(8), hold on, grid on;
xlabel('Czas [s]');
ylabel('Poziom h2 [m]');
title('Zbiornik nr 2 - skok fwe2');


% Laboratorium 06 - model dokładny i zlinearyzowany kaskady


% Deklaracja modeli Simulinka
model_dokl = 'sim06a';
model_zlin = 'sim06b';
% Deklaracja danych do obliczeń
A1 = 10 * 10;
A2 = A1;
Aw1 = 2 * 1;
Aw2 = Aw1;
fwe1max = 5;
Tab_fwe1 = [0, 0.5*fwe1max, 0.9*fwe1max];
fwe2 = 0.1*fwe1max;
du1 = 0.1*fwe1max;
du2 = 0;
czas_skoku = 15;
g = 10;
% Obliczanie współczynników a1 oraz a2
h2max = ((fwe1max + fwe2)^2)/(2*g*(Aw2)^2);
h1max = (fwe1max)^2/(2*g*(Aw1)^2) + h2max;
a2 = Aw2*sqrt(2*g*h2max)/h2max;
a1 = Aw1*sqrt(2*g*(h1max-h2max))/(h1max-h2max);
% Wykresy dokładnego modelu kaskady
for i=1:size(Tab_fwe1,2)
    fwe1 = Tab_fwe1(i);
    h20 = ((fwe1 + fwe2)^2)/(2*g*(Aw2)^2);
    h10 = (fwe1)^2/(2*g*(Aw1)^2) + h20;
    sim(model_dokl,150);
    figure(fig1);
    plot(ans.tout,ans.simout1,kolor_dokl(i,:));
    figure(fig2);
    plot(ans.tout,ans.simout2,kolor_dokl(i,:));
    dh1 = ans.simout1 - h10;
    dh2 = ans.simout2 - h20;
    figure(fig5);
    plot(ans.tout,dh1,kolor_dokl(i,:));
    figure(fig6);
    plot(ans.tout,dh2,kolor_dokl(i,:));
end
% Wykresy zlinearyzowanego modelu kaskady - skok fwe1
for i=1:size(Tab_fwe1,2)
    fwe1 = Tab_fwe1(i);
    h20 = (fwe1 + fwe2)/a2;
    h10 = fwe1/a1 + h20;
    sim(model_zlin,150);
    figure(fig1);
    plot(ans.tout,ans.simout1,kolor_zlin(i,:));
    figure(fig2);
    plot(ans.tout,ans.simout2,kolor_zlin(i,:));
    figure(fig3);
    plot(ans.tout,ans.simout1,kolor_zlin(i,:));
    figure(fig4);
    plot(ans.tout,ans.simout2,kolor_zlin(i,:));
    dh1 = ans.simout1 - h10;
    dh2 = ans.simout2 - h20;
    figure(fig5);
    plot(ans.tout,dh1,kolor_zlin2(i,:));
    figure(fig6);
    plot(ans.tout,dh2,kolor_zlin2(i,:));
end
figure(fig1);
legend(opis1);
figure(fig2);
legend(opis1);
figure(fig5);
legend(opis1);
figure(fig6);
legend(opis1);
% Wykresy zlinearyzowanego modelu kaskady - skok fwe2
du1 = 0;
du2 = 0.1*fwe1max;
h20 = (fwe1 + fwe2)/a2;
h10 = fwe1/a1 + h20;
sim(model_zlin,150);
figure(fig7);
plot(ans.tout,ans.simout1,kolor_zlin(1,:));
figure(fig8);
plot(ans.tout,ans.simout2,kolor_zlin(1,:));


% Laboratorium 07 - równania stanu kaskady


% Deklaracja modelu simulinka
model_rs = 'sim06c';
% Deklaracja danych do obliczeń
A = [-a1/A1,a1/A1;a1/A2,(-a1-a2)/A2];
B = [1/A1,0;0,1/A2];
C = [1,0;0,1];
D = [0,0;0,0];
du1 = 0.1*fwe1max;
du2 = 0;
% Wykresy równań stanu kaskady - skok fwe1
for i=1:size(Tab_fwe1,2)
    fwe1 = Tab_fwe1(i);
    u = [fwe1;fwe2];
    sim(model_rs,150);
    figure(fig3);
    plot(ans.tout,ans.simout1,kolor_rs(i,:));
    figure(fig4);
    plot(ans.tout,ans.simout2,kolor_rs(i,:));
end
% Wykresy równań stanu kaskady - skok fwe2
du1 = 0;
du2 = 0.1*fwe1max;
sim(model_rs,150);
figure(fig7);
plot(ans.tout,ans.simout1,kolor_rs(2,:));
figure(fig8);
plot(ans.tout,ans.simout2,kolor_rs(2,:));


% Laboratorium 08 - transmitancje kaskady


% Deklaracja modelu Simulinka
model_trs = 'sim06d';
% Deklaracja danych do obliczeń
M1 = [A1,a1];
M2 = [A2,a1+a2];
M = [A1*A2,A1*a1+A1*a2+A2*a1,a1*a2];
du1 = 0.1*fwe1max;
du2 = 0;
% Wykresy transmitancji kaskady - skok fwe1
for i=1:size(Tab_fwe1,2)
    fwe1 = Tab_fwe1(i);
    h20 = (fwe1 + fwe2)/a2;
    h10 = fwe1/a1 + h20;
    sim(model_trs,150);
    figure(fig3);
    plot(ans.tout,ans.simout1,kolor_trs(i,:));
    figure(fig4);
    plot(ans.tout,ans.simout2,kolor_trs(i,:));
end
figure(fig3);
legend(opis2);
figure(fig4);
legend(opis2);
% Wykresy transmitancji kaskady - skok fwe2
du1 = 0;
du2 = 0.1*fwe1max;
h20 = (fwe1 + fwe2)/a2;
h10 = fwe1/a1 + h20;
sim(model_trs,150);
figure(fig7);
plot(ans.tout,ans.simout1,kolor_trs(3,:));
legend(opis3);
figure(fig8);
plot(ans.tout,ans.simout2,kolor_trs(3,:));
legend(opis3);