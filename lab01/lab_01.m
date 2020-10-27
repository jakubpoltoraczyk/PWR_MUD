clear all;
figure;
hold on;
grid on;
x=[-10:1:10];
a=[-2:.5:2];
colors=['r- ';'b--';'g: ';'y-.'];
for i=1:size(a,2)
    line = mod(i,size(colors,1))+1;
    plot(x,a(i)*x.*x,colors(line,:));
end
xlabel('os x');
ylabel('os y');
title('tytul wykresu');
text(1,2,'tekst (1,2)');