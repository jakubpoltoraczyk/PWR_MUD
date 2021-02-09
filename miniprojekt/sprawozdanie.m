clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Miniprojekt - obiekt 7.2.3 b).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Część pierwsza - model dokładny

% Dane do rysowania wykresów
kolor = ['r';'b';'g'];
kolor_dh = ['r ';'bx';'g '];
opis = ['Punkt pracy nr 1';'Punkt pracy nr 2';'Punkt pracy nr 3'];
fig1 = figure(1), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na Tzew');
fig2 = figure(2), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na Tzew');
fig3 = figure(3), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na Tkz');
fig4 = figure(4), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na Tkz');
fig5 = figure(5), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na fp');
fig6 = figure(6), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na fp');
fig21 = figure(21), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 1 - skok na Tzew');
fig22 = figure(22), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 2 - skok na Tzew');
fig23 = figure(23), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 1 - skok na Tkz');
fig24 = figure(24), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 2 - skok na Tkz');
fig25 = figure(25), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 1 - skok na fp');
fig26 = figure(26), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 2 - skok na fp');
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
czas_obs = 2500;
czas_skoku = 60;
dufp = 0;
duTzew = 0;
duTkz = 0;
% % Wykresy dla różnych punktów pracy przy tym samym zakłóceniu
% for i=1:size(Tab_Tzew,2)
%     Tzew = Tab_Tzew(i);
%     Tkz = Tab_Tkz(i);
%     fp = Tab_fp(i);
%     Tw10 = ((Ko+Ks+Cp*Pp*fp)*(Cp*Pp*Tkz*fp+Ks*Tzew)+Ko*Ks*Tzew)/((Cp*Pp*fp+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fp));
%     Tw20 = (Tw10*(Ko+Cp*Pp*fp)+Ks*Tzew)/(Ko+Ks+Cp*Pp*fp);
%     % Skok na Tzew
%     duTzew = 4;
%     sim(model,czas_obs);
%     figure(fig1);
%     plot(ans.tout,ans.simout1,kolor(i,:));
%     figure(fig2);
%     plot(ans.tout,ans.simout2,kolor(i,:));
%     duTzew = 0;
%     dh1 = ans.simout1 - Tw10;
%     dh2 = ans.simout2 - Tw20;
%     figure(fig21);
%     plot(ans.tout,dh1,kolor_dh(i,:));
%     figure(fig22);
%     plot(ans.tout,dh2,kolor_dh(i,:));
%     % Skok na Tkz
%     duTkz = 3;
%     sim(model,czas_obs);
%     figure(fig3);
%     plot(ans.tout,ans.simout1,kolor(i,:));
%     figure(fig4);
%     plot(ans.tout,ans.simout2,kolor(i,:));
%     duTkz = 0;
%     dh1 = ans.simout1 - Tw10;
%     dh2 = ans.simout2 - Tw20;
%     figure(fig23);
%     plot(ans.tout,dh1,kolor_dh(i,:));
%     figure(fig24);
%     plot(ans.tout,dh2,kolor_dh(i,:));
%     % Skok na fp
%     dufp = 0.1*fpN;
%     sim(model,czas_obs);
%     figure(fig5);
%     plot(ans.tout,ans.simout1,kolor(i,:));
%     figure(fig6);
%     plot(ans.tout,ans.simout2,kolor(i,:));
%     dufp= 0;
%     dh1 = ans.simout1 - Tw10;
%     dh2 = ans.simout2 - Tw20;
%     figure(fig25);
%     plot(ans.tout,dh1,kolor_dh(i,:));
%     figure(fig26);
%     plot(ans.tout,dh2,kolor_dh(i,:));
% end
% figure(fig1); legend(opis); figure(fig2); legend(opis);
% figure(fig3); legend(opis); figure(fig4); legend(opis);
% figure(fig5); legend(opis); figure(fig6); legend(opis);
% figure(fig21); legend(opis); figure(fig22); legend(opis);
% figure(fig23); legend(opis); figure(fig24); legend(opis);
% figure(fig25); legend(opis); figure(fig26); legend(opis);

% % Część druga - charakterystyki statyczne
% 
% % Dane do rysowania wykresów
% fig7 = figure(7), hold on, grid on, xlabel('Tzew [C]'), ylabel('Tw1 [C]'), title('Zależność temperatury pomieszczenia nr 1 od temperatury zewnętrznej');
% fig8 = figure(8), hold on, grid on, xlabel('Tkz [C]'), ylabel('Tw1 [C]'), title('Zależność temp. pomieszczenia nr 1 od temp. wprowadzanego powietrza');
% fig9 = figure(9), hold on, grid on, xlabel('fp [m^3/s]'), ylabel('Tw1 [C]'), title('Zależność temperatury pomieszczenia nr 1 od przepływu powietrza');
% fig10 = figure(10), hold on, grid on, xlabel('Tzew [C]'), ylabel('Tw2 [C]'), title('Zależność temperatury pomieszczenia nr 2 od temperatury zewnętrznej');
% fig11 = figure(11), hold on, grid on, xlabel('Tkz [C]'), ylabel('Tw2 [C]'), title('Zależność temp. pomieszczenia nr 2 od temp. wprowadzanego powietrza');
% fig12 = figure(12), hold on, grid on, xlabel('fp [m^3/s]'), ylabel('Tw2 [C]'), title('Zależność temperatury pomieszczenia nr 2 od przepływu powietrza');
% % Wykresy charakterystyk statycznych poszczególnych wyjść od wejść
% % Tw1 i Tw2 od Tzew
% WTzew = [0:0.1*TzewN:1.5*TzewN];
% Tw1 = ((Ko+Ks+Cp*Pp*fpN)*(Cp*Pp*TkzN*fpN+Ks.*WTzew)+Ko*Ks.*WTzew)/((Cp*Pp*fpN+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fpN));
% Tw2 = (Tw1*(Ko+Cp*Pp*fpN)+Ks.*WTzew)/(Ko+Ks+Cp*Pp*fpN);
% figure(fig7);
% plot(WTzew,Tw1,'r');
% plot(TzewN,Tw1N,'bx');
% figure(fig10);
% plot(WTzew,Tw2,'r');
% plot(TzewN,Tw2N,'bx');
% % Tw1 i Tw2 od Tkz
% WTkz = [0:0.1*TkzN:1.5*TkzN];
% Tw1 = ((Ko+Ks+Cp*Pp*fpN)*(Cp*Pp.*WTkz*fpN+Ks*TzewN)+Ko*Ks*TzewN)/((Cp*Pp*fpN+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fpN));
% Tw2 = (Tw1*(Ko+Cp*Pp*fpN)+Ks*TzewN)/(Ko+Ks+Cp*Pp*fpN);
% figure(fig8);
% plot(WTkz,Tw1,'r');
% plot(TkzN,Tw1N,'bx');
% figure(fig11);
% plot(WTkz,Tw2,'r');
% plot(TkzN,Tw2N,'bx');
% % Tw1 i Tw2 od fp
% Wfp = [0:0.1*fpN:1.5*fpN];
% Tw1 = ((Ko+Ks+Cp*Pp.*Wfp).*(Cp*Pp*TkzN.*Wfp+Ks*TzewN)+Ko*Ks*TzewN)./((Cp*Pp.*Wfp+Ks+Ko).^2-Ko*(Ko+Cp*Pp.*Wfp));
% Tw2 = (Tw1.*(Ko+Cp*Pp.*Wfp)+Ks*TzewN)./(Ko+Ks+Cp*Pp.*Wfp);
% figure(fig9);
% plot(Wfp,Tw1,'r');
% plot(fpN,Tw1N,'bx');
% figure(fig12);
% plot(Wfp,Tw2,'r');
% plot(fpN,Tw2N,'bx');

% Część trzecia - równania stanu

% Dane do simulinka i rysowania wykresów
kolor_rs = ['c';'m'];
kolor_dhrs = ['c ';'mx']
opis = ['Punkt pracy nr 1';'Punkt pracy nr 2'];
fig13 = figure(13), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na Tzew, fp = fpN');
fig14 = figure(14), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na Tzew, fp = fpN');
fig15 = figure(15), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na Tkz, fp = fpN');
fig16 = figure(16), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na Tkz, fp = fpN');
fig17 = figure(17), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na Tzew, fp != fpN');
fig18 = figure(18), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na Tzew, fp != fpN');
fig19 = figure(19), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 1 - skok na Tkz, fp != fpN');
fig20 = figure(20), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Temperatura pomieszczenia nr 2 - skok na Tkz, fp != fpN');
fig27 = figure(27), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 1 - skok na Tzew, fp = fpN');
fig28 = figure(28), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 2 - skok na Tzew, fp = fpN');
fig29 = figure(29), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 1 - skok na Tkz, fp = fpN');
fig30 = figure(30), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 2 - skok na Tkz, fp = fpN');
fig31 = figure(31), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 1 - skok na Tzew, fp != fpN');
fig32 = figure(32), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 2 - skok na Tzew, fp != fpN');
fig33 = figure(33), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 1 - skok na Tkz, fp != fpN');
fig34 = figure(34), hold on, grid on, xlabel('Czas [s]'), ylabel('Temperatura [C]'), title('Przyrost temperatury pomieszczenia nr 2 - skok na Tkz, fp != fpN');
model2 = 'sim02';
czas_obs = 3000;
% Punkty pracy
dTzew = 5;
dTkz = -5;
dfp = 0.5;
Tab_Tzew = [TzewN,TzewN+dTzew];
Tab_Tkz = [TkzN,TkzN+dTkz];
C = [1,0;0,1];
D = [0,0;0,0];
% Wykresy dla różnych punktów pracy przy tym samym zakłóceniu
% Wersja nr 1 - fp = fpN
fp = fpN;
for i=1:size(Tab_Tzew,2)
    Tzew = Tab_Tzew(i);
    Tkz = Tab_Tkz(i);
    A = [-(Cp*Pp*fp+Ks+Ko)/Cv1,Ko/Cv1;(Cp*Pp*fp+Ko)/Cv2,-(Cp*Pp*fp+Ks+Ko)/Cv2];
    B = [(Cp*Pp*fp)/Cv1,Ks/Cv1;0,Ks/Cv2];
    u = [Tkz;Tzew];
    Tw10 = ((Ko+Ks+Cp*Pp*fp)*(Cp*Pp*Tkz*fp+Ks*Tzew)+Ko*Ks*Tzew)/((Cp*Pp*fp+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fp));
    Tw20 = (Tw10*(Ko+Cp*Pp*fp)+Ks*Tzew)/(Ko+Ks+Cp*Pp*fp);
    % Skok na Tzew
    duTzew = 4;
    sim(model2,czas_obs);
    figure(fig13);
    plot(ans.tout,ans.simout1,kolor_rs(i,:));
    figure(fig14);
    plot(ans.tout,ans.simout2,kolor_rs(i,:));
    duTzew = 0;
    dh1 = ans.simout1 - Tw10;
    dh2 = ans.simout2 - Tw20;
    figure(fig27);
    plot(ans.tout,dh1,kolor_dhrs(i,:));
    figure(fig28);
    plot(ans.tout,dh2,kolor_dhrs(i,:));
    % Skok na Tkz
    duTkz = 3;
    sim(model2,czas_obs);
    figure(fig15);
    plot(ans.tout,ans.simout1,kolor_rs(i,:));
    figure(fig16);
    plot(ans.tout,ans.simout2,kolor_rs(i,:));
    dh1 = ans.simout1 - Tw10;
    dh2 = ans.simout2 - Tw20;
    figure(fig29);
    plot(ans.tout,dh1,kolor_dhrs(i,:));
    figure(fig30);
    plot(ans.tout,dh2,kolor_dhrs(i,:));
    duTkz = 0;
end
figure(fig13); legend(opis); figure(fig14); legend(opis);
figure(fig15); legend(opis); figure(fig16); legend(opis);
figure(fig27); legend(opis); figure(fig28); legend(opis);
figure(fig29); legend(opis); figure(fig30); legend(opis);
% Wersja nr 2 - fp != fpN
fp = fpN*dfp;
for i=1:size(Tab_Tzew,2)
    Tzew = Tab_Tzew(i);
    Tkz = Tab_Tkz(i);
    A = [-(Cp*Pp*fp+Ks+Ko)/Cv1,Ko/Cv1;(Cp*Pp*fp+Ko)/Cv2,-(Cp*Pp*fp+Ks+Ko)/Cv2];
    B = [(Cp*Pp*fp)/Cv1,Ks/Cv1;0,Ks/Cv2];
    u = [Tkz;Tzew];
    Tw10 = ((Ko+Ks+Cp*Pp*fp)*(Cp*Pp*Tkz*fp+Ks*Tzew)+Ko*Ks*Tzew)/((Cp*Pp*fp+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fp));
    Tw20 = (Tw10*(Ko+Cp*Pp*fp)+Ks*Tzew)/(Ko+Ks+Cp*Pp*fp);
    % Skok na Tzew
    duTzew = 4;
    sim(model2,czas_obs);
    figure(fig17);
    plot(ans.tout,ans.simout1,kolor_rs(i,:));
    figure(fig18);
    plot(ans.tout,ans.simout2,kolor_rs(i,:));
    duTzew = 0;
    dh1 = ans.simout1 - Tw10;
    dh2 = ans.simout2 - Tw20;
    figure(fig31);
    plot(ans.tout,dh1,kolor_dhrs(i,:));
    figure(fig32);
    plot(ans.tout,dh2,kolor_dhrs(i,:));
    % Skok na Tkz
    duTkz = 3;
    sim(model2,czas_obs);
    figure(fig19);
    plot(ans.tout,ans.simout1,kolor_rs(i,:));
    figure(fig20);
    plot(ans.tout,ans.simout2,kolor_rs(i,:));
    duTkz = 0;
    dh1 = ans.simout1 - Tw10;
    dh2 = ans.simout2 - Tw20;
    figure(fig33);
    plot(ans.tout,dh1,kolor_dhrs(i,:));
    figure(fig34);
    plot(ans.tout,dh2,kolor_dhrs(i,:));
end
figure(fig17); legend(opis); figure(fig18); legend(opis);
figure(fig19); legend(opis); figure(fig20); legend(opis);
figure(fig31); legend(opis); figure(fig32); legend(opis);
figure(fig33); legend(opis); figure(fig34); legend(opis);