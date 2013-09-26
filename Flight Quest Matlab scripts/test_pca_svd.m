function [proj_data,PC,var] = test_pca_svd(data)
[m,n] = size(data);
mu = mean(data,2);
data = data - repmat(mu,1,n);

Y = data' / sqrt(n-1);
[u,S,PC] = svd(Y);
S = diag(S);
var = S .* S;

proj_data = PC' * data;