% Returns the accuracy of multiclass classifier W
% W: (d+1) x c
% X: (d+1) x n
% y: 1 x n
function acc = multiclass_accuracy(W, X, y)

%pred = zeros(size(y));     % No need to preallocate

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

[~, pred] = max(Pyx);  % pred: 1 x n, pred(i) is prediction of xi, base 1

nacc = sum(y == pred);
acc = nacc / length(y);
