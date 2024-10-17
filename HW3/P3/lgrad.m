function grad = lgrad(X)
    % Computes the gradient of the function f at point X
    % X is a vector [x1; x2]
    
    a = 1.5;
    x1 = X(1);
    x2 = X(2);
    
    % Compute u and f
    u = -((x1 * x2 - a)^2 + (x2 - a)^2);
    f_val = -exp(u);
    
    % Compute partial derivaltives of u
    du_dx1 = -2 * (x1 * x2 - a) * x2;
    du_dx2 = -2 * (x1 * x2 - a) * x1 - 2 * (x2 - a);
    
    % Compute gradient components
    grad = zeros(2,1);
    grad(1) = f_val * du_dx1;
    grad(2) = f_val * du_dx2;
end