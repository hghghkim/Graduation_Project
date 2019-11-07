% Savitzky Golay
function [SG2] = Savitzky_Golay_1st (x)

[XS, YS] = size(x);
N = 3;%3                % Order of polynomial fit
F = 5;%5                % Window length = Smoothing point
[~,g] = sgolay(N,F);   % Calculate S-G coefficients

% y = []5*sin(0.4*pi*x)+randn(size(x));  % Sinusoid with noise
    YY = zeros(XS, YS);
    HalfWin  = ((F+1)/2) -1;
    SG1 = zeros(1, YS);

for ii = 1:XS
    for n = (F+1)/2:YS-(F+1)/2,
        % 1st differential
        SG1(n) =   dot(g(:,2), x(ii,n - HalfWin: n + HalfWin));
  
  % 2nd differential
%   SG2(n) = 2*dot(g(:,3)', x(n - HalfWin: n + HalfWin))';
    end
    YY(ii,:) = SG1;
end

SG2 = YY;