% Oracle mlr returns the function and gradient evaluated at w. 
% W: (d+1) x c
% X: (d+1) x n
% y: 1 x n
function [f, g] = oracle_mlr(W, X, y)

%f = 0;
%g = zeros(size(W));    % No need to preallocate
Lambda = ones(size(W)) * 10;
Lambda(1,:) = 0; % do not penalize the bias term

% Y(i,j) = 1 if y(j) == i, otherwise 0
Y = full(sparse(y, 1:length(y), 1)); % c x n

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TODO: Complete this function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%eWX: c x n, eWX(i, j) = exp(Wi^T Xj)
eWX = exp(W' * X);
%inv_sum_eWX: 1 x n, inv_sum_eWX(1, j) = 1 / sum(exp(Wk^T Xj))
inv_sum_eWX = 1 ./ sum(eWX);
%Pyx: c x n, Pyx(i, j) = P(y = i | xj)
Pyx = eWX .* repmat(inv_sum_eWX, size(W, 2), 1);

f = sum(sum(Y .* log(Pyx)))...
    - sum(sum(Lambda .* (W .^ 2))) / 2;

g = X * ( Y - Pyx )' - Lambda .* W;
