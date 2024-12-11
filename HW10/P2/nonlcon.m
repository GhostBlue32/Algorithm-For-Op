% Nonlinear constraint function
function [c, ceq] = nonlcon(xn)
    % No inequality constraints
    c = [];
    % Equality constraint x2 = x1^2 - 1
    ceq = xn(2) - xn(1)^2 + 1;
end