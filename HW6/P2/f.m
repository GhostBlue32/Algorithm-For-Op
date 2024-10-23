function fx = f(x1, x2)
    fx = -exp(-0.5 * (x1 .* x2 - 0.75).^2 - 2 * (x1 - 1.5).^2);
end