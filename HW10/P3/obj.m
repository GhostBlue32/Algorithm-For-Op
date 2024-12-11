function f = obj(xn)
    % Function to compute f(x) as per the given formula
    % with beta = 10 and d = 2
    %
    % Input:
    %   xn - a vector of size d (here, d = 2)
    %
    % Output:
    %   y - the computed value of the function f(xn)
    
    x1 = xn(1);
    x2 = xn(2);
    m = 10;
    f = -sin(x1) .* sin(x1.^2/pi).^(2 * m) - sin(x2) * sin(2 .* x2.^2/pi).^(2 * m) + 2;
end