% Returns the function and gradient evaluated at w. 
% w: (d+1) x 1
% X: (d+1) x n
% y: 1 x n
function [f, g] = oracle_lr(w, X, y)

%f = 0;
%g = zeros(size(w));    % No need to preallocate
lambda = ones(size(w)) * 10; % used in Q2.2.7
lambda(1) = 0; % do not penalize the bias term

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TODO: Complete the function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hx = sigmoid(w' * X);    % hx: 1 x n

f = y * log(hx)' + (1 - y) * log(1 - hx)'...
    - sum(lambda .* (w .^ 2)) / 2;

diff_y_hx = y - hx;
g = (diff_y_hx * X')' - lambda .* w;   % g: (d + 1) x 1
