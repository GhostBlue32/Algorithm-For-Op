function xstar = opt(lambda)
    f = @(u)(1-lambda) * f1(u(1), u(2)) + lambda * f2(u(1), u(2));
    xstar = fminsearch(f, [15,20]);
end