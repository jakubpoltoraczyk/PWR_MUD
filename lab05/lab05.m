clear all;
close all;
%Dane stałe
model = 'sim05';
kolor = ['r';'b';'g';'m'];
opis = ['Równanie a';'Równanie b';'Równanie c';'Równanie d'];
x0 = 0;
x10 = 0;
u0 = 0;
du = 1;
E1 = 0.6;
E2 = 0.3;
w1 = 0.9;
w2 = 0.4;
TabE = [E1,E1,E2,E2];
Tabw = [w1,w2,w2,w1*E1/E2];
%Rysowanie biegunow na plaszczyznie zespolonej
figure(1);
hold on; 
grid on;
axis([-1.5 0.5 -2 2]);
title('Położenie biegunów w przestrzeni zespolonej');
xlabel('Część rzeczywista');
ylabel('Część urojona');
L1 = (-1)*TabE.*Tabw + Tabw.*sqrt(TabE.*TabE-1);
L2 = (-1)*TabE.*Tabw - Tabw.*sqrt(TabE.*TabE-1);
for i=1:size(L1,2)
    plot(real(L1(i)),imag(L1(i)),strcat(kolor(i),'x'));
    plot(real(L2(i)),imag(L2(i)),strcat(kolor(i),'x'))
end
%Rysowanie odpowiedzi skokowej odpowiednich rownan
figure(2);
hold on;
grid on;
title('Odpowiedz skokowa');
xlabel('t[s]');
ylabel('h[t]');
for i=1:size(TabE,2)
    E = TabE(i);
    w = Tabw(i);
    sim(model,30);
    plot(ans.tout,ans.simout,strcat(kolor(i),'-'));
end
legend(opis);