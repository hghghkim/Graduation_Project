% predata analysis
% smoothing -> moving average
function [Md] = smoothing_mean (x,Msize)

[nX,mX]= size(x);
Md = zeros(nX,mX);
for i=1:nX
    a = x(i,:)';
    Md(i,:) = smooth(a,Msize,'moving');
end
% C1 = reshape(y1,10,4);
% y1 = filter(ones(1,windowSize)/windowSize,1,rowdata(1,:));

% windowSize = Msize;