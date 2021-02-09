clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Miniprojekt - obiekt 7.2.3 b).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Deklaracja danych stałych

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

% Część pierwsza - charakterystyki statyczne

% Dane do rysowania wykresów
fig1 = figure(1), hold on, grid on, xlabel('Tzew [C]'), ylabel('Tw1 [C]'), title('Zależność temperatury pomieszczenia nr 1 od temperatury zewnętrznej');
fig2 = figure(2), hold on, grid on, xlabel('Tzew [C]'), ylabel('Tw2 [C]'), title('Zależność temperatury pomieszczenia nr 2 od temperatury zewnętrznej');
fig3 = figure(3), hold on, grid on, xlabel('Tkz [C]'), ylabel('Tw1 [C]'), title('Zależność temp. pomieszczenia nr 1 od temp. wprowadzanego powietrza');
fig4 = figure(4), hold on, grid on, xlabel('Tkz [C]'), ylabel('Tw2 [C]'), title('Zależność temp. pomieszczenia nr 2 od temp. wprowadzanego powietrza');
fig5 = figure(5), hold on, grid on, xlabel('fp [m^3/s]'), ylabel('Tw1 [C]'), title('Zależność temperatury pomieszczenia nr 1 od przepływu powietrza');
fig6 = figure(6), hold on, grid on, xlabel('fp [m^3/s]'), ylabel('Tw2 [C]'), title('Zależność temperatury pomieszczenia nr 2 od przepływu powietrza');
% Wykresy charakterystyk statycznych poszczególnych wyjść od wejść
% Tw1 i Tw2 od Tzew
WTzew = [0:0.1*TzewN:1.5*TzewN];
Tw1 = ((Ko+Ks+Cp*Pp*fpN)*(Cp*Pp*TkzN*fpN+Ks.*WTzew)+Ko*Ks.*WTzew)/((Cp*Pp*fpN+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fpN));
Tw2 = (Tw1*(Ko+Cp*Pp*fpN)+Ks.*WTzew)/(Ko+Ks+Cp*Pp*fpN);
figure(fig1);
plot(WTzew,Tw1,'r');
plot(TzewN,Tw1N,'bx');
figure(fig2);
plot(WTzew,Tw2,'r');
plot(TzewN,Tw2N,'bx');
% Tw1 i Tw2 od Tkz
WTkz = [0:0.1*TkzN:1.5*TkzN];
Tw1 = ((Ko+Ks+Cp*Pp*fpN)*(Cp*Pp.*WTkz*fpN+Ks*TzewN)+Ko*Ks*TzewN)/((Cp*Pp*fpN+Ks+Ko)^2-Ko*(Ko+Cp*Pp*fpN));
Tw2 = (Tw1*(Ko+Cp*Pp*fpN)+Ks*TzewN)/(Ko+Ks+Cp*Pp*fpN);
figure(fig3);
plot(WTkz,Tw1,'r');
plot(TkzN,Tw1N,'bx');
figure(fig4);
plot(WTkz,Tw2,'r');
plot(TkzN,Tw2N,'bx');
% Tw1 i Tw2 od fp
Wfp = [0:0.1*fpN:1.5*fpN];
Tw1 = ((Ko+Ks+Cp*Pp.*Wfp).*(Cp*Pp*TkzN.*Wfp+Ks*TzewN)+Ko*Ks*TzewN)./((Cp*Pp.*Wfp+Ks+Ko).^2-Ko*(Ko+Cp*Pp.*Wfp));
Tw2 = (Tw1.*(Ko+Cp*Pp.*Wfp)+Ks*TzewN)./(Ko+Ks+Cp*Pp.*Wfp);
figure(fig5);
plot(Wfp,Tw1,'r');
plot(fpN,Tw1N,'bx');
figure(fig6);
plot(Wfp,Tw2,'r');
plot(fpN,Tw2N,'bx');

% Część druga - model nieliniowy (odpowiedzi skokowe + porównanie)

% Dane do rysowania wykresów
kolor_rs = ['r';'b'];
kolor_tr = ['g--';'c--'];
kolor_rs_prwn = ['r- ';'b--'];
kolor_tr_prwn = ['gx ';'mo '];
opis = ['Punkt pracy nr 1 - rs.';'Punkt pracy nr 1 - tr.';'Punkt pracy nr 2 - rs.';'Punkt pracy nr 2 - tr.'];
% Punkty pracy i wartość parametru przepływu
dTkz = -5;
dTzew = 5;
dfp = 0.5;
Tab_Tzew = [TzewN,TzewN+dTzew];
Tab_Tkz = [TkzN,TkzN+dTkz];
Tab_fp = [fpN,fpN*dfp];
% Wykresy odpowiedzi skokowych
for j=1:size(Tab_fp,2)
    fp = Tab_fp(j);
    for i=1:size(Tab_Tzew,2)
        % Równania stanu
        A = [-(Cp*Pp*fp+Ks+Ko)/Cv1,Ko/Cv1;(Cp*Pp*fp+Ko)/Cv2,-(Cp*Pp*fp+Ks+Ko)/Cv2];
        B = [(Cp*Pp*fp)/Cv1,Ks/Cv1;0,Ks/Cv2];
        C = [1,0;0,1];
        D = [0,0;0,0];
        obiekt_rs = ss(A,B,C,D,'InputName',['Tkz ';'Tzew'],'OutputName',['Twew1';'Twew2']);
        % Transmitancja
        M1 = [Cv1,Cp*Pp*fp+Ks+Ko];
        M2 = [Cv2,Cp*Pp*fp+Ks+Ko];
        M = [Cv1*Cv2,(Cv1+Cv2)*(Cp*Pp*fp+Ks+Ko),(Cp*Pp*fp+Ks+Ko)^2-Ko*(Cp*Pp*fp+Ko)];
        L1 = M2*Cp*Pp*fp;
        L2 = Ko*Ks + M2*Ks;
        L3 = Cp*Pp*fp*(Cp*Pp*fp+Ko);
        L4 = M1*Ks+Ks*Ko+Ks*Cp*Pp*fp;
        obiekt_tr = tf({L1,L2;L3,L4},{M,M;M,M});
        % Odpowiedz skokowa
        t = 0:100:2500;
        Tzew = Tab_Tzew(i);
        Tkz = Tab_Tkz(i);
        u = [Tkz,Tzew];
        du = [3,4];
        stepDataOptions();
        opcje = stepDataOptions('InputOffset',u,'StepAmplitude',du);
        figure(j+6);
        step(obiekt_rs,t,opcje,kolor_rs(i,:));
        hold on;
        step(obiekt_tr,t,opcje,kolor_tr(i,:));
        % Porównanie odpowiedzi skokowych
        t = 0:100:2500;
        u = [0,0];
        du = [3,4];
        stepDataOptions();
        opcje = stepDataOptions('InputOffset',u,'StepAmplitude',du);
        figure(j+8);
        step(obiekt_rs,t,opcje,kolor_rs_prwn(i,:));
        hold on;
        step(obiekt_tr,t,opcje,kolor_tr_prwn(i,:));
    end
end
figure(7); title('Odpowiedzi skokowe obiektu dla fp = fpN'); legend(opis);
figure(8); title('Odpowiedzi skokowe obiektu dla fp != fpN'); legend(opis);
figure(9); title('Przyrost temperatury obiektu dla fp = fpN'); legend(opis);
figure(10); title('Przyrost temperatury obiektu dla fp != fpN'); legend(opis);