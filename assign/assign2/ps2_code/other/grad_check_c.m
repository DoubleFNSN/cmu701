function err = grad_check(oracle, t, varargin)

h = 1e-6;
d = length(t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TODO: Complete the function
% Hint: Use [f,g] = oracle(t, varargin{:}) to call oracle with the rest of the
% parameters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

errsum = 0;
he = zeros(size(t));

[~, gt] = oracle(t, varargin{:});
for i = 1 : d
    he(i, :) = h;
    if i > 1
        he(i - 1, :) = 0;
    end
    [ft_plus_h, ~] = oracle(t + he, varargin{:});
    [ft_minus_h, ~] = oracle(t - he, varargin{:});
    ghatt = (ft_plus_h - ft_minus_h) / (2 * h);
    errsum = errsum + mean(abs(ghatt - gt(i, :)));  % TODO: Is this correct???? ghatt and gt(i, :) are 1 x c
end
err = errsum / d;