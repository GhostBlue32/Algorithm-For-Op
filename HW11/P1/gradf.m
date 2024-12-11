function grad = gradf(val, lambda)
    x = val(1);
    y = val(2);
    A1 = [2.1213, 0.7071; -2.1213, 0.7071];
    A2 = [3.5640, -0.4540; 1.8160, 0.8910];
    gf1 = (A1 + A1') * [x - 2; y + 2];
    gf2 = (A2 + A2') * [x + 2.5; y - 2.5];
    grad = (1 - lambda) * gf1 + lambda * gf2;
end