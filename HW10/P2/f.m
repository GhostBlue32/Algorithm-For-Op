function y = f(xn)
    % Function to compute f(x) as per the given formula
    % with beta = 10 and d = 2
    %
    % Input:
    %   xn - a vector of size d (here, d = 2)
    %
    % Output:
    %   y - the computed value of the function f(xn)
    
    beta = 10;
    d = 2;
    y = 0;
    for i = 1:d
        S = 0;
        for j = 1:d
            term = (j + beta) * (xn(j)^i - 1 / j^i);
            S = S + term;
        end
        y = y + S^2;
    end
end