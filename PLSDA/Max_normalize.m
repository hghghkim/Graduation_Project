% Max 정규화 보정 스펙트럼
function [YY] = Max_normalize (x)

[XS YS] = size(x);
YY = zeros(XS, YS);

for i = 1:XS;
    YY(i,:) = x(i,:)'/max(x(i,:));
    
end