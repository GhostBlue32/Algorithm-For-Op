function grad = g(x, beta)
    % Computes the gradient of the residual with respect to beta
    denominator = (x - beta(4))^2 + beta(3)^2;
    g3 = - (1 / pi) * (x - beta(4)) / denominator;
    g4 = -(1 / pi) * beta(3) / denominator;
    grad = [1, -x, g3, g4];
end