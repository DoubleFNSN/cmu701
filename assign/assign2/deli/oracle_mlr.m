% Oracle mlr returns the function and gradient evaluated at w. 
% W: (d+1) x c
% X: (d+1) x n
% y: 1 x n
function [f, g] = oracle_mlr(W, X, y)

f = 0;
g = zeros(size(W));
Lambda = ones(size(W)) * 10;
Lambda(1,:) = 0; % do not penalize the bias term





% Y(i,j) = 1 if y(j) == i, otherwise 0
Y = full(sparse(y, 1:length(y), 1)); % c x n

fenmu_o = 1 ./ sum( exp(W' * X) );
fenmu = repmat(fenmu_o, size(W, 2), 1);

prob = exp(W' * X) .* fenmu;

f = sum(sum(Y .* log(prob))) - sum(sum(Lambda .* (W .^ 2))) / 2;

g = X * (Y - prob)' - Lambda .* W;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TODO: Complete this function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
