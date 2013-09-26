function [proj_data,PC,var] = pca_test(data)
[m,n] = size(data);
mu = mean(data,2);
data = data - repmat(mu,1,n);

covar = 1 / (N-1) * data * data';
[PC, var] = eig(covar);

var = diag(var);
[temp, rindices] = sort(-1*V);
var = var(rindices);
PC = PC(:,rindices);

proj_data = PC' * data; 