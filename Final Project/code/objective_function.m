%% Objective Function
function o_i = objective_function(position)
    % Computes f(x, y) = x^4/4 - x^2/2 + x/10 + y^2/2 + e^x/5
    x = position(1);
    y = position(2);
    %o_i = (x^4)/4 - (x^2)/2 + x/10 + (y^2)/2 + exp(x)/5;
    o_i = (1.1-x)^2+50*(y-x^2)^2;
    %o_i = 20 + x^2 + y^2 - 10*(cos(2*pi*x) + cos(2*pi*y));
    %o_i = 2 - sin(x)*(sin(x^2/pi))^20 + sin(y)*(sin(2*y^2/pi)^20);
end