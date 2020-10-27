clear all;
close all;
% Dane stałe
t = 0:0.20:20;
opis = ['Xw ';'Xs1';'Xs2';'Xs ';'X  '];
L1 = -1/4;
L2 = -3;
% Dane dla punktu nr 1
A1 = 16/11;
A2 = -4/33;
U = 2/3;
Xw = t;
Xw(:) = U;
Xs1 = A1*exp(L1*t);
Xs2 = A2*exp(L2*t);
Xs = Xs1 + Xs2;
X = Xs1 + Xs2 + Xw;
% Wykresy dla punktu nr 1
figure(1);
hold on;
grid on;
plot(t,Xw,'g-.');
plot(t,Xs1,'b--');
plot(t,Xs2,'c--');
plot(t,Xs,'r-');
plot(t,X,'k');
title('Rozwiazanie dla punktu nr 1');
xlabel('t[s]');
ylabel('X');
legend(opis);
% Dane dla punktu nr 2
A1 = 0;
A2 = 0;
Xs1 = A1*exp(L1*t);
Xs2 = A2*exp(L2*t);
Xs = Xs1 + Xs2;
X = Xs1 + Xs2 + Xw;
% Wykresy dla punktu nr 2
figure(2);
hold on;
grid on;
plot(t,Xw,'g-.');
plot(t,Xs1,'b--');
plot(t,Xs2,'c--');
plot(t,Xs,'r-');
plot(t,X,'k');
title('Rozwiazanie dla punktu nr 2');
xlabel('t[s]');
ylabel('X');
legend(opis);
% Dane dla punktu nr 3
figure(3);
hold on;
grid on;
A1 = -8/11;
A2 = 2/33;
Xs1 = A1*exp(L1*t);
Xs2 = A2*exp(L2*t);
Xs = Xs1 + Xs2;
X = Xs1 + Xs2 + Xw;
% Wykresy dla punktu nr 3
figure(3);
hold on;
grid on;
plot(t,Xw,'g-.');
plot(t,Xs1,'b--');
plot(t,Xs2,'c--');
plot(t,Xs,'r-');
plot(t,X,'k');
title('Rozwiazanie dla punktu nr 3');
xlabel('t[s]');
ylabel('X');
legend(opis);
% Dane dla punktu nr 4
figure(4);
hold on;
grid on;
A1 = 2/11;
A2 = -2/11;
U = 0;
Xw(:) = U;
Xs1 = A1*exp(L1*t);
Xs2 = A2*exp(L2*t);
Xs = Xs1 + Xs2;
X = Xs1 + Xs2 + Xw;
% Wykresy dla punktu nr 4
figure(4);
hold on;
grid on;
plot(t,Xw,'g-.');
plot(t,Xs1,'b--');
plot(t,Xs2,'c--');
plot(t,Xs,'r-');
plot(t,X,'k');
title('Rozwiazanie dla punktu nr 4');
xlabel('t[s]');
ylabel('X');
legend(opis);