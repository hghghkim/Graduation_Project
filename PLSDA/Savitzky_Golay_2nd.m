% Savitzky Golay
function [SG1] = Savitzky_Golay_2nd (x)

[XS, YS] = size(x);
N = 3;                % Order of polynomial fit
F = 9;                % Window length = Smoothing point
[~,g] = sgolay(N,F);   % Calculate S-G coefficients

    YY = zeros(XS, YS);
    HalfWin  = ((F+1)/2) -1;
    SG2 = zeros(1, YS);

for ii = 1:XS
    for n = (F+1)/2:YS-(F+1)/2,
        % 1st differential
%         SG1(n) =   dot(g(:,2), x(ii,n - HalfWin: n + HalfWin));
  
      % 2nd differential
      SG2(n) = 2*dot(g(:,3)', x(ii,n - HalfWin: n + HalfWin))';
    end
    YY(ii,:) = SG2;
end

SG1 = YY;