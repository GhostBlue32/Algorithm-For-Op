function H = H_matrix(x, y, beta)
    % x: vector of x_n values
    % y: vector of y_n values
    % beta: vector [beta1, beta2] containing beta1 and beta2

    beta1 = beta(1);
    beta2 = beta(2);

    N = length(x);  % assuming x and y have the same length

    % Initialize the components of the Hessian matrix
    H11 = 0;  % top-left
    H12 = 0;  % top-right (and bottom-left because it's symmetric)
    H22 = 0;  % bottom-right
    H21 = 0;

    for n = 1:N
        x_n = x(n);
        y_n = y(n);

        % Calculate each element of the matrix
        H11 = H11 + 2 * (1 - cos(beta2 * x_n))^2;
        H12 = H12 + 4 * x_n * beta1 * sin(beta2 * x_n) * (1 - cos(beta2 * x_n)) - 2 * y_n * x_n * sin(beta2 * x_n);
        H21 = H21 + 2 * x_n * sin(beta2 * x_n) * (2 * beta1 * (1 - cos (beta2 * x_n)) - y_n);
        H22 = H22 + 2 * beta1^2 * x_n^2 * sin(beta2 * x_n)^2;
    end

    % Construct the Hessian matrix H
    H = [H11, H12; H21, H22];

end