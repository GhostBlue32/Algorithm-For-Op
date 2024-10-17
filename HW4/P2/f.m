function fx = f(x, beta)
    beta1 = beta(1);
    beta2 = beta(2);
    fx = beta1 * (1 - cos(beta2 * x));
end