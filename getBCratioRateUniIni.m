function bcr = getBCratioRateUniIni( mAdj, rateArray,varargin )
% Computes the critical b/c ratio for a graph given by weighted 
% adjacency matrix mAdj and arbitrary update rate (column vector). 


n = length(mAdj);
w = sum(mAdj);
W = sum(w);
pi = (w/W).';
if length(varargin) < 2
    Rem = findRemeetingTimesRateUniIni(mAdj,rateArray);
else
    Rem = varargin{2};
end;
Rem = Rem - diag(diag(Rem));
if length(varargin) < 1
    mInt = mAdj;
else
    mInt = varargin{1};
end
P10 = normalizedLaplacian(mAdj)+speye(n);
P01 = normalizedLaplacian(mInt)+speye(n);
P20 = P10 * P10;
P21 = P20 * P01;

T20 = sum((P20.*Rem).')*pi;
T21 = sum((P21.*Rem).')*pi;
T01 = sum((P01.*Rem).')*pi;
bcr = T20 / (T21 - T01);

end

