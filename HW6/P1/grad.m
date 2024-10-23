function g = grad(X)
    x1 = X(1);
    x2 = X(2);
    lambda = X(3);

    g1 = -lambda / (x1 + 1 / 3)^2 - (x2 * (x1 * x2 - 0.75) + 4 * (x1 - 1.5)) * f(x1, x2);
    g2 = -lambda - x1 * (x1 * x2 - 0.75) * f(x1, x2);
    g3 = 1 / (x1 + 1 / 3) - x2 - 0.5;
    g = [g1;g2;g3];
end