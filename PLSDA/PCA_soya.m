clear all; clc;
wavelength=xlsread('New_SWIR_wavelength.xlsx'); % FTNIR wave
% range='130:1866';

aa= xlsread('non_viable_seed.xlsx');
bb= xlsread('viable_seed.xlsx');

Total = [aa;bb];
% total = Total(:,str2num(range));
TT= Mean_normalize(Total);
% TT= Total(1:end,1:195);
% figure
% plot(ww,TT);
% xlabel('Wavelength(nm)')
% ylabel('Reflectance')
%% mean plot
mean_a= mean(aa);
mean_b= mean(bb);
figure (1), plot(mean_a(1:end,1:57), '--r','LineWidth',2);
hold on;
figure (1), plot(mean_b(1:end,1:57), '--g','Linewidth',2);
xlim([1000 2500])
%label('Wavelength(nm)')
ylabel('Reflectance')
legend('one','thirty','Location','NW');

%PCA function 
[pcs, scores, variances, t2] = princomp(TT);
per_var = 100*(variances/sum(variances));

%2D plot
figure(1)
plot(scores(1:57,1),scores(1:57,2),'ro','Linewidth',2);%first group
hold on
plot(scores(58:114,1),scores(58:114,2),'go','Linewidth',2);% second gorup
% plot(0,scores(1:57,2),'ro','Linewidth',2);%first group
% hold on
% plot(1,scores(58:114,2),'go','Linewidth',2);% second gorup

xlabel('PC1')
ylabel('PC2')
legend('non_viable','viable',2);
title ('2D classification plot');

% % variance plot 
% plot(1:length(variances),per_var,'o:b', 'LineWidth',2);
% grid;
% xlabel('eigenvalues');
% ylabel('weight (%)');
% title('Variance plot')

% PC plot
 figure(88)
 plot(wavelength(2:end,1),pcs(2:end,1),'r','LineWidth',2)
 hold on
 plot(wavelength,pcs(:,2),'b','LineWidth',2)
 hold on;
 plot(wavelength,pcs(:,3),'m','LineWidth',2)
hold on;
plot(wavelength,pcs(:,4),'g','LineWidth',2)

xlim([1000 2500]); 
xlabel('Wavelength (cm-1)');
legend('PC1','PC2','PC3')

%3D plot
figure(3)
scatter3(scores(1:57,1),scores(1:57,2),scores(1:57,3), 'ro', 'Linewidth',2) % pure group
hold on
scatter3(scores(58:114,1),scores(58:114,2),scores(58:114,3), 'go', 'Linewidth',2)% 3% gorup

xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
legend('non_viable','viable',2)
title('3D classification plot');

%%




