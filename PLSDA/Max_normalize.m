% Max ����ȭ ���� ����Ʈ��
function [YY] = Max_normalize (x)

[XS YS] = size(x);
YY = zeros(XS, YS);

for i = 1:XS;
    YY(i,:) = x(i,:)'/max(x(i,:));
    
end