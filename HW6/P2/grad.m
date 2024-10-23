function g = grad(X)
    x1 = X(1);
    x2 = X(2);
    B = 1 / (x1 + 1 / 3) - x2 - 0.5;
    global rho;
    g1 =  - (x2 * (x1 * x2 - 0.75) + 4 * (x1 - 1.5)) * f(x1, x2) - 2 * rho * B / (x1 + 1 / 3)^2;
    g2 = -2 * rho * B - x1 * (x1 * x2 - 0.75) * f(x1, x2);
    g = [g1;g2];
end