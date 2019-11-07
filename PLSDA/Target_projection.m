function [t,w,p,sr]=tp(X,b)
% b = regression vector from PLS (beta coefficient)


w=b/norm(b);
t=X*w;
p=X'*t/(t'*t);

Xtp=t*p';
Xr=X-Xtp;

%Compute selectivity ratio
for i=1:size(X,2)
  vartp(i)=sumsqr(Xtp(:,i));
  varr(i)=sumsqr(Xr(:,i));
end
sr=vartp./(varr+eps); 