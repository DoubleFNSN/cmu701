function err = grad_check(oracle, t, varargin)

h = 1e-6;
d = length(t);

X = varargin{1};
y = varargin{2};


g = zeros(d,1);

record = zeros(d,1);

[~,g] = oracle(t,X,y);

for i=1:d
    back = t(i);
    
    t(i) = back + h;
    [f1, ~] = oracle(t,X,y);
    
    t(i) = back - h;
    [f2, ~] = oracle(t,X,y);
    
    %record(i) = abs( (f1(i) - f2(i))/(2*h) - (f1(i) - f(i))/(h) );
    
    record(i) = abs( (f1 - f2)/(2*h) - g(i) );
    
    %record(i) = abs( (f1(i) - f2(i))/(2*h) - (g1(i)+g2(i))/2 );
end
err = mean(record);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TODO: Complete the function
% Hint: Use [f,g] = oracle(t, varargin{:}) to call oracle with the rest of the
% parameters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
