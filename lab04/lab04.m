clear all;
%close all; % tego nie robić!
% przełączać się na włączone już ploty z lab03
%Dane stałe
opis = ['Xw  ';'Xs1 ';'Xs2 ';'Xs  ';'X   ';'Xsim'];
model = 'sim04';
kolor = 'm--';
xlab = 't[s]';
ylab = 'x';
a = 4;
b = 13;
c = 3;
k = 2;
du = 0;
x10 = 0;
%Dane dla punktu nr 1
u0 = 1;
x0 = 2;
%Wykres dla punktu nr 1
sim(model,20);
figure(1);
hold on;
grid on;
plot(ans.tout,ans.simout,kolor);
xlabel(xlab);
ylabel(ylab);
title('Rozwiazanie dla punktu nr 1');
legend(opis);
%Dane dla punktu nr 2
x0 = k*u0/c;
%Wykres dla punktu nr 2
sim(model,20);
figure(2);
hold on;
grid on;
plot(ans.tout,ans.simout,kolor);
xlabel(xlab);
ylabel(ylab);
title('Rozwiazanie dla punktu nr 2');
legend(opis);
%Dane dla punktu nr 3
x0 = 0;
%Wykres dla punktu nr 3
sim(model,20);
figure(3);
hold on;
grid on;
plot(ans.tout,ans.simout,kolor);
xlabel(xlab);
ylabel(ylab);
title('Rozwiazanie dla punktu nr 3');
legend(opis);


