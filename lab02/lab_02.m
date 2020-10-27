clear all;
close all;
%Deklarowanie stalych i zmiennych
TzewN = -20;
TwewN = 20;
QgN = 1000;
TpN = 16;
a = 0.25;
Kcw = QgN/(TwewN*(a+1)-TzewN-a*TpN);
Kcwp = a * Kcw;
Kcp = (Kcwp*(TwewN-TpN))/(TpN-TzewN);
Qg = [0:250:QgN];
Tzew = [0:-5:TzewN];
colors = ['r-';'b-';'g-';'y-';'c-'];
%Rysowanie wykresow funkcji Twew = f(Qg)
figure;
hold on;
grid on;
tzew_names = ['0C  ';'-5C ';'-10C';'-15C';'-20C'];
for i=1:size(Tzew,2);
    Tp = (Kcwp*Qg + Tzew(i)*(Kcwp*Kcp+Kcwp*Kcw+Kcw*Kcp))/(Kcw*Kcp+Kcw*Kcwp+Kcwp*Kcp);
    Twew = (Qg-Kcp*(Tp-Tzew(i)))/Kcw + Tzew(i);
    plot(Qg,Twew,colors(mod(i,size(Tzew,2))+1));
    first_names(i,:) = tzew_names(i,:);
end
plot(QgN,TwewN,'x');
xlabel('Qg[W]');
ylabel('Twew[C]');
leg = legend(first_names,'Location','southeast');
title(leg,'Tzew[C]');
%Rysowanie wykresow funkcji Twew = f(Tzew)
figure;
hold on;
grid on;
qg_names = ['0W   ';'250W ';'500W ';'750W ';'1000W'];
for i=1:size(Qg,2);
    Tp = (Kcwp*Qg(i) + Tzew*(Kcwp*Kcp+Kcwp*Kcw+Kcw*Kcp))/(Kcw*Kcp+Kcw*Kcwp+Kcwp*Kcp);
    Twew = (Qg(i)-Kcp*(Tp-Tzew))/Kcw + Tzew;
    plot(Tzew,Twew,colors(mod(i,size(Tzew,2))+1));
    second_names(i,:) = qg_names(i,:);
end
plot(TzewN,TwewN,'x');
xlabel('Tzew[C]');
ylabel('Twew[C]');
leg = legend(second_names,'Location','southeast');
title(leg,'Qg[W]');