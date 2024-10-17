function H = hess0(X)
    % Computes the Hessian matrix of the function f at point X
    % X is a vector [x1; x2]
    
    a = 1.5;
    x1 = X(1);
    x2 = X(2);
    
    % Compute u and f
    u = -((x1 * x2 - a)^2 + (x2 - a)^2);
    f_val = -exp(u);
    
    % Compute first-order partial derivatives of u
    du_dx1 = -2 * (x1 * x2 - a) * x2;
    du_dx2 = -2 * (x1 * x2 - a) * x1 - 2 * (x2 - a);
    
    % Compute second-order partial derivatives of u
    d2u_dx1dx1 = -2 * x2^2;
    d2u_dx2dx2 = -2 * x1^2 - 2;
    d2u_dx1dx2 = -2 * (2 * x1 * x2 - a);
    % Note: d2u_dx1dx2 = d2u_dx2dx1 due to symmetry
    
    % Compute Hessian elements
    H11 = f_val * (du_dx1^2 + d2u_dx1dx1);
    H12 = f_val * (du_dx1 * du_dx2 + d2u_dx1dx2);
    H22 = f_val * (du_dx2^2 + d2u_dx2dx2);
    
    % Assemble Hessian matrix
    H = [H11, H12; H12, H22];
end