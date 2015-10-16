% Returns the accuracy of multiclass classifier W
% W: (d+1) x c
% X: (d+1) x n
% y: 1 x n
function acc = multiclass_accuracy(W, X, y)

pred = zeros(size(y));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TODO: Complete this function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fenmu_o = 1 ./ sum( exp(W' * X) );
fenmu = repmat(fenmu_o, size(W,2), 1);
prob = exp(W' * X) .* fenmu;

[~, pred] = max(prob);

nacc = sum(y == pred);
acc = nacc / length(y);
