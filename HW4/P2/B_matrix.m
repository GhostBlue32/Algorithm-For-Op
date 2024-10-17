function B = B_matrix(x, y, beta)
    beta1 = beta(1);
    beta2 = beta(2);
    N = length(x);

    % Initialize the Jacobian matrix J
    J = zeros(N, 2);

    for n = 1:N
        x_n = x(n);

        % Fill in the Jacobian matrix
        J(n, 1) = 1 - cos(beta2 * x_n);          % First column
        J(n, 2) = beta1 * x_n * sin(beta2 * x_n); % Second column
    end

    B = 2 * (J') * J;
end