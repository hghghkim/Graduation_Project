% Mean 정규화 보정 스펙트럼
function [Spectral] = Mean_normalize (x)

[XS1 YS1] = size(x);
SpectralMean = mean(x,2);
Spectral = zeros(XS1, YS1);

for i = 1:XS1;
    Spectral(i,:) = x(i,:)'/SpectralMean(i,:);
end