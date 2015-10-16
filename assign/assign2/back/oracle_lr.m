% Returns the function and gradient evaluated at w. 
% w: (d+1) x 1
% X: (d+1) x n
% y: 1 x n
function [f, g] = oracle_lr(w, X, y)

lambda = ones(size(w)) * 10; % used in Q2.2.7
lambda(1) = 0; % do not penalize the bias term

f = 0;

g = zeros(size(w));

% f is the objective, alse the log likelihood
f = dot((0+y), log(sigmoid(w'*X))) + dot((1-y), log((1-sigmoid(w'*X)))) - sum(lambda .* w .^ 2) / 2;

% g are the gradients for w, size (d+1) x 1

g = X * ((y+0) - sigmoid(w'*X))' - lambda .* w;


end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TODO: Complete the function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
