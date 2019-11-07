

clear all; close all;

x1= xlsread('Calibration.xlsx');
% x2= xlsread('Validation.xlsx');
% x = cat(1, x1(:,2:end), x2(:, 2:end));
% xa= autoscale(x);
xc= MSC(x1(:,2:end));
% 
% x3= x1(1:end, 2:end);
% x4= x2(1:end, 2:end);

% All_samples= [x3;x4];

All_samples= xc;


size_spectrum1 = xlsread('New_SWIR_wavelength.xlsx');
wavelength1 = size_spectrum1(:,1)';
wavelength = (1./wavelength1)*10^7;

all=All_samples;

%Tsample=total(:,75:end);
%group = textread('Group.xlsx', '%s');%read group file
%group = xlsread('Group.xlsx');
[pcs, scores, variances, t2] = princomp(all);

per_var = 100*(variances/sum(variances));

figure(1);
plot(wavelength1,pcs(:,1),'b')
hold on;

plot(wavelength1,pcs(:,2),'g')
hold on;

plot(wavelength1,pcs(:,3),'r')
% figure(4);
% % plot(wavelength1,pcs(:,4),'b')
legend('PC1','PC2','PC3','Location','NW')
 xlim([1000 2400]); 
xlabel('Wavelength(nm)')
title ('Loading plot')

% figure(5);
% scatter3(pcs(:,1), pcs(:,2),pcs(:,3));
% figure(6);
% 
% plot(pcs(:,1), pcs(:,2),'o');

figure(7);
scatter3(scores(1:31,10), scores(1:34,11), scores(1:100,12), 'ro')
hold on;
scatter3(scores(35:end,10), scores(35:end,11), scores(101:end,12), 'bo')
xlabel('1st Principal Component');
ylabel('2nd Principal Component');
zlabel('3rd Principal Component');
legend('treated','nontreated','Location','NW')
  title('PCA')

% figure(8);
% scatter3(pcs(:,1), pcs(:,2), pcs(:,3), 'o')


% figure(9);
% scatter3(scores(:,1), scores(:,2),scores(:,3), group, 'k', '+Vo*sx.^<>pd')

figure(10);
scatter(scores(1:34,1),scores(1:34,2), 'ro')
hold on;
scatter(scores(35:end,1),scores(35:end,2), 'bo')
xlabel('1st Principal Component');
ylabel('2nd Principal Component');
zlabel('3rd Principal Component')
legend('treadted','non_treated','Location','NW')
  title('Classification')
% axis([-1 2 -0.6 0.3]);      % Meat
% axis([-1.5 2 -0.6 0.8]);   % Skin6