%% Rastrigin Function with Constraints
function o_i = rastrigin_function(position)
    % f(x, y) = 20 + x^2 + y^2 - 10*(cos(2*pi*x) + cos(2*pi*y))
    x = position(1);
    y = position(2);
    A = 10;
    o_i = 2*A + (x^2 - A * cos(2*pi*x)) + (y^2 - A * cos(2*pi*y));
end

%% Himmelblau's Function with Constraints
function o_i = himmelblau_function(position)
    % f(x, y) = (x^2 + y - 11)^2 + (x + y^2 - 7)^2
    x = position(1);
    y = position(2);
    o_i = (x^2 + y - 11)^2 + (x + y^2 - 7)^2;
end

%% Michalewicz Function with Constraints
function o_i = michalewicz_function(position)
    % f(x, y) = -sin(x)*(sin(x^2/pi))^10 - sin(y)*(sin(2*y^2/pi))^10
    x = position(1);
    y = position(2);
    m = 10;  % Parameter 'm' controls the steepness of valleys
    o_i = -sin(x) * (sin(x^2 / pi))^m - sin(y) * (sin(2*y^2 / pi))^m;
end

%% Schwefel Function with Constraints
function o_i = schwefel_function(position)
    % f(x, y) = 2*418.9829 - (x*sin(sqrt(|x|)) + y*sin(sqrt(|y|)))
    x = position(1);
    y = position(2);
    o_i = 2 * 418.9829 - (x * sin(sqrt(abs(x))) + y * sin(sqrt(abs(y))));
end

%% Easom Function with Constraints
function o_i = easom_function(position)
    % f(x, y) = -cos(x)*cos(y)*exp(-((x - pi)^2 + (y - pi)^2))
    x = position(1);
    y = position(2);
    o_i = -cos(x) * cos(y) * exp(-((x - pi)^2 + (y - pi)^2));
end