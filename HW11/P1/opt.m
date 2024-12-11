function xstar = opt(lambda)
    f = @(val)gradf(val, lambda);
    options = optimoptions('fsolve', 'Display', 'none');
    xstar = fsolve(f, [0, 0], options);
    %f = @(u)(1-lambda) * f1(u(1), u(2)) + lambda * f2(u(1), u(2));
    %xstar = fminsearch(f, [0,0]);
end