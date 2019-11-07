% SNV 보정 스펙트럼
function [YY] = SNV (x)

[~, YS] = size(x);
SpectralMean = mean(x,2);
STDEV_Spectra = std(x,0,2);
% YY = (x-((SpectralMean')*ones(1,XS))')./(((STDEV_Spectra')*ones(1,XS))');

% for i = 
YY = (x-(SpectralMean)*ones(1,YS))./(STDEV_Spectra*ones(1,YS));


% YY = zeros(XS, YS);
%     for ii = 1:YS;
% %         x = x';
% %         Xx = [ones(YS,1) x(ii,:)'];
%        SpectralMean1 = SpectralMean(:,ii);
%        b = regress(x(ii,:)',SpectralMean1);
% %         a = sum(bint)/2;
%         YY(ii,:) = (x(ii,:)-(b(1).*ones(1,YS)))./(b(2).*ones(1,YS));
% %     YY(i,:) = x(i,:)./SpectralMean(1,:);
%     end
% %     Xmsc = (x-YYY(i,:))/YYY(1,:);
%     
% % end