clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Miniprojekt - obiekt 7.2.3 b).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Część pierwsza - model dokładny

% Dane do rysowania wykresów
kolor = ['r';'b';'g'];
opis = ['Punkt pracy nr 1';'Punkt pracy nr 2';'Punkt pracy nr 3';'Równania stanu  ';'Równania stanu  '];
fig1 = figure(1), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na Tzew');
fig2 = figure(2), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na Tzew');
fig3 = figure(3), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na Tkz');
fig4 = figure(4), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na Tkz');
fig5 = figure(5), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na fp');
fig6 = figure(6), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na fp');
% Wartości nominalne
TzewN = -20;
TkzN = 30;
Tw1N = 20;
Tw2N = 15;
qkN = 6000;
Cp = 1000;
Pp = 1.2;
% Wymiary obiektu
h = 3;
V1 = 30*h;
V2 = 40*h;
Cv1 = Cp*Pp*V1;
Cv2 = Cp*Pp*V2;
% Parametry statyczne
fpN = qkN/(Cp*Pp*(TkzN-Tw1N));
Ks = (Cp*Pp*fpN*(TkzN-Tw2N))/(Tw1N+Tw2N-2*TzewN);
Ko = (qkN-Ks*(Tw1N-TzewN))/(Tw1N-Tw2N);
% Punkty pracy
dTzew = 5;
dTkz = -5;
dfp = 0.5;
Tab_Tzew = [TzewN,TzewN+dTzew,TzewN+dTzew];
Tab_Tkz = [TkzN,TkzN+dTkz,TkzN+dTkz];
Tab_fp = [fpN,fpN,fpN*dfp];
% Dane dla simulinka
model = "sim01";
czas_obs = 1400;
czas_skoku = 40;
dufp = 0;
duTzew = 0;
duTkz = 0;
% Wykresy dla różnych punktów pracy przy tym samym zakłóceniu
for i=3:size(Tab_Tzew,2)
    Tzew = Tab_Tzew(i);
    Tkz = Tab_Tkz(i);
    fp = Tab_fp(i);
    Tw10 = ((Ko+Ks+Cp*Pp*fp)*(Cp*Pp*Tkz*fp+Ks*Tzew)+Ko*Ks*Tzew)/((Cp*Pp*fp+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fp));
    Tw20 = (Tw10*(Ko+Cp*Pp*fp)+Ks*Tzew)/(Ko+Ks+Cp*Pp*fp);
    % Skok na Tzew
    duTzew = 4;
    sim(model,czas_obs);
    figure(fig1);
    plot(ans.tout,ans.simout1,kolor(i,:));
    figure(fig2);
    plot(ans.tout,ans.simout2,kolor(i,:));
    duTzew = 0;
    % Skok na Tkz
    duTkz = 3;
    sim(model,czas_obs);
    figure(fig3);
    plot(ans.tout,ans.simout1,kolor(i,:));
    figure(fig4);
    plot(ans.tout,ans.simout2,kolor(i,:));
    duTkz = 0;
    % Skok na fp
    dufp = 0.1*fpN;
    sim(model,czas_obs);
    figure(fig5);
    plot(ans.tout,ans.simout1,kolor(i,:));
    figure(fig6);
    plot(ans.tout,ans.simout2,kolor(i,:));
    dufp= 0;
end
%figure(fig1); legend(opis); figure(fig2); legend(opis);
%figure(fig3); legend(opis); figure(fig4); legend(opis);
%figure(fig5); legend(opis); figure(fig6); legend(opis);

% Część druga - charakterystyki statyczne

% Dane do rysowania wykresów
fig7 = figure(7), hold on, grid on, xlabel('Tzew [C]'), ylabel('Tw1 [C]'), title('Zależność temperatury pomieszczenia nr 1 od temperatury zewnętrznej');
fig8 = figure(8), hold on, grid on, xlabel('Tkz [C]'), ylabel('Tw1 [C]'), title('Zależność temperatury pomieszczenia nr 1 od temperatury wprowadzanego powietrza');
fig9 = figure(9), hold on, grid on, xlabel('fp [m^3/s]'), ylabel('Tw1 [C]'), title('Zależność temperatury pomieszczenia nr 1 od przepływu powietrza');
fig10 = figure(10), hold on, grid on, xlabel('Tzew [C]'), ylabel('Tw2 [C]'), title('Zależność temperatury pomieszczenia nr 2 od temperatury zewnętrznej');
fig11 = figure(11), hold on, grid on, xlabel('Tkz [C]'), ylabel('Tw2 [C]'), title('Zależność temperatury pomieszczenia nr 2 od temperatury wprowadzanego powietrza');
fig12 = figure(12), hold on, grid on, xlabel('fp [m^3/s]'), ylabel('Tw2 [C]'), title('Zależność temperatury pomieszczenia nr 2 od przepływu powietrza');
% Wykresy charakterystyk statycznych poszczególnych wyjść od wejść
% Tw1 i Tw2 od Tzew
WTzew = [0:0.1*TzewN:1.5*TzewN];
Tw1 = ((Ko+Ks+Cp*Pp*fpN)*(Cp*Pp*TkzN*fpN+Ks.*WTzew)+Ko*Ks.*WTzew)/((Cp*Pp*fpN+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fpN));
Tw2 = (Tw1*(Ko+Cp*Pp*fpN)+Ks.*WTzew)/(Ko+Ks+Cp*Pp*fpN);
figure(fig7);
plot(WTzew,Tw1,'r');
plot(TzewN,Tw1N,'bx');
figure(fig10);
plot(WTzew,Tw2,'r');
plot(TzewN,Tw2N,'bx');
% Tw1 i Tw2 od Tkz
WTkz = [0:0.1*TkzN:1.5*TkzN];
Tw1 = ((Ko+Ks+Cp*Pp*fpN)*(Cp*Pp.*WTkz*fpN+Ks*TzewN)+Ko*Ks*TzewN)/((Cp*Pp*fpN+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fpN));
Tw2 = (Tw1*(Ko+Cp*Pp*fpN)+Ks*TzewN)/(Ko+Ks+Cp*Pp*fpN);
figure(fig8);
plot(WTkz,Tw1,'r');
plot(TkzN,Tw1N,'bx');
figure(fig11);
plot(WTkz,Tw2,'r');
plot(TkzN,Tw2N,'bx');
% Tw1 i Tw2 od fp
Wfp = [0:0.1*fpN:1.5*fpN];
Tw1 = ((Ko+Ks+Cp*Pp.*Wfp).*(Cp*Pp*TkzN.*Wfp+Ks*TzewN)+Ko*Ks*TzewN)./((Cp*Pp.*Wfp+Ks+Ko).^2-Ko*(Ko+Cp*Pp.*Wfp));
Tw2 = (Tw1.*(Ko+Cp*Pp.*Wfp)+Ks*TzewN)./(Ko+Ks+Cp*Pp.*Wfp);
figure(fig9);
plot(Wfp,Tw1,'r');
plot(fpN,Tw1N,'bx');
figure(fig12);
plot(Wfp,Tw2,'r');
plot(fpN,Tw2N,'bx');

% Część trzecia - równania stanu

% Dane do simulinka i rysowania wykresów
kolor_rs = ['mo';'co'];
model2 = 'sim02';
% Punkty pracy
dTzew = 5;
dTkz = -5;
dfp = 0.5;
Tab_Tzew = [TzewN,TzewN+dTzew];
Tab_Tkz = [TkzN,TkzN+dTkz];
Tab_fp = [fpN,fpN*dfp];
C = [1,0;0,1];
D = [0,0;0,0];
% Wykresy dla różnych punktów pracy przy tym samym zakłóceniu
for i=2:size(Tab_fp,2)
    Tzew = Tab_Tzew(i);
    Tkz = Tab_Tkz(i);
    fp = Tab_fp(i);
    A = [-(Cp*Pp*fp+Ks+Ko)/Cv1,Ko/Cv1;(Cp*Pp*fp+Ko)/Cv2,-(Cp*Pp*fp+Ks+Ko)/Cv2];
    B = [(Cp*Pp*fp)/Cv1,Ks/Cv1;0,Ks/Cv2];
    u = [Tkz;Tzew];
    % Skok na Tzew
    duTzew = 4;
    sim(model2,czas_obs);
    figure(fig1);
    plot(ans.tout,ans.simout1,kolor_rs(i,:));
    figure(fig2);
    plot(ans.tout,ans.simout2,kolor_rs(i,:));
    duTzew = 0;
    % Skok na Tkz
    duTkz = 3;
    sim(model2,czas_obs);
    figure(fig3);
    plot(ans.tout,ans.simout1,kolor_rs(i,:));
    figure(fig4);
    plot(ans.tout,ans.simout2,kolor_rs(i,:));
    duTkz = 0;
end

% Laboratorium 08 - transmitancje kaskady

% Dane do simulinka i rysowania wykresów
kolor_trs = ['kx';'yx'];
model3 = 'sim03';
% Punkty pracy
dTzew = 5;
dTkz = -5;
dfp = 0.5;
Tab_Tzew = [TzewN,TzewN+dTzew];
Tab_Tkz = [TkzN,TkzN+dTkz];
Tab_fp = [fpN,fpN*dfp];
% Wykresy dla różnych punktów pracy przy tym samym zakłóceniu
for i=2:size(Tab_fp,2)
    Tzew = Tab_Tzew(i);
    Tkz = Tab_Tkz(i);
    fp = Tab_fp(i);
    M1 = [Cv1,Cp*Pp*fp+Ks+Ko];
    M2 = [Cv2,Cp*Pp*fp+Ks+Ko];
    M = [Cv1*Cv2,(Cv1+Cv2)*(Cp*Pp*fp+Ks+Ko),(Cp*Pp*fp+Ks+Ko)^2-Ko*(Cp*Pp*fp+Ko)];
    L1 = Ko*Ks + M2*Ks;
    L2 = M2*Cp*Pp*fp;
    L3 = M1*Ks+Ks*Ko+Ks*Cp*Pp*fp;
    L4 = Cp*Pp*fp*(Cp*Pp*fp+Ko);
    Tw10 = ((Ko+Ks+Cp*Pp*fp)*(Cp*Pp*Tkz*fp+Ks*Tzew)+Ko*Ks*Tzew)/((Cp*Pp*fp+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fp));
    Tw20 = (Tw10*(Ko+Cp*Pp*fp)+Ks*Tzew)/(Ko+Ks+Cp*Pp*fp);
% Skok na Tzew
    duTzew = 4;
    sim(model3,czas_obs);
    figure(fig1);
    plot(ans.tout,ans.simout1,kolor_trs(i,:));
    figure(fig2);
    plot(ans.tout,ans.simout2,kolor_trs(i,:));
    duTzew = 0;
    % Skok na Tkz
    duTkz = 3;
    sim(model3,czas_obs);
    figure(fig3);
    plot(ans.tout,ans.simout1,kolor_trs(i,:));
    figure(fig4);
    plot(ans.tout,ans.simout2,kolor_trs(i,:));
    duTkz = 0;
end