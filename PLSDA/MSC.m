% MSC 보정 스펙트럼
function [YY] = MSC (x)

[XS YS] = size(x);
SpectralMean = mean(x,1);

% [b,bint] = regress(SpectralMean',x');
% Xx = [ones(YS,1) x'];
% for i = 1:YS;
%     [b, bint] = regress(x(i,:)',SpectralMean');
    YY = zeros(XS, YS);
    for ii = 1:XS;
%         x = x';
%         Xx = [ones(YS,1) x(ii,:)'];
        SpectralMean1 = [ones(YS,1) SpectralMean'];
       b = regress(x(ii,:)',SpectralMean1);
%         a = sum(bint)/2;
        YY(ii,:) = (x(ii,:)-(b(1).*ones(1,YS)))./(b(2).*ones(1,YS));
%     YY(i,:) = x(i,:)./SpectralMean(1,:);
    end
%     Xmsc = (x-YYY(i,:))/YYY(1,:);
    
% end