function [T,P,Q,W,R2X,R2Y]=weight(X,Y,A)
%  A=number of PLS factors 
%  =X-weights 
%# T=scores 
%# P=X-loadings 
%# Q=Y-loadings 
% R2X=percentage of X variance explained by each PLS factor
% R2Y=percentage of Y-variance explained by each PLS factor
[n,p]=size(X);

Xorig=X;
Yorig=Y;

ssqX=sum(sum((X.^2)));
ssqY=sum(Y.^2);

for a=1:A
    
    W(:,a)=X'*Y;
    W(:,a)=W(:,a)/norm(W(:,a));
    
    
    T(:,a)=X*W(:,a);
    P(:,a)=X'*T(:,a)/(T(:,a)'*T(:,a));
    Q(a,1)=Y'*T(:,a)/(T(:,a)'*T(:,a));
    
    X=X-T(:,a)*P(:,a)';
    Y=Y-T(:,a)*Q(a,1);
    R2X(a,1)=(T(:,a)'*T(:,a))*(P(:,a)'*P(:,a))/ssqX*100;
    R2Y(a,1)=(T(:,a)'*T(:,a))*(Q(a,1)'*Q(a,1))/ssqY*100;
   
end
Wstar=W*(P'*W)^(-1); 
B=Wstar*Q;
