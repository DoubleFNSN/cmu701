% Returns the accuracy of binary classifier w
% w: (d+1) x 1
% X: (d+1) x n
% y: 1 x n
function acc = binary_accuracy(w, X, y)

%pred = zeros(size(y));     % No need to preallocate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TODO: Complete this function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pred = sigmoid(w' * X);
pred(pred < 0.5) = 0;
pred(pred ~= 0) = 1;

nacc = sum(y == pred);
acc = nacc / length(y);
