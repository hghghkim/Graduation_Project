function VIP=vip(x,y,t,w)

% t: socres
% w: weight

% VIP=sqrt(p*q/s);


[m,p]=size(x);
[m,h]=size(t);
[p,h]=size(w);

for i=1:h
    corr=corrcoef(y,t(:,i));
    co(i,1)=corr(1,2)^2;
end
s=sum(co);

for i=1:p
    for j=1:h
        d(j,1)=co(j,1)*w(i,j)^2;
    end
    q=sum(d);
    VIP(i,1)=sqrt(p*q/s);
end


    
