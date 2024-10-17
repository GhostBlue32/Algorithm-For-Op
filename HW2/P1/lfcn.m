function fx = lfcn(x, A, b)
    fx = 0.5 * x' * A * x - x' * b;
end