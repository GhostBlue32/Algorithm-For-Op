function Y = lgrad(X)
    xn = X(1)^3 - X(1) + 1 / 10 +  exp(X(1)) / 5;
    yn = X(2);
    Y = [xn; yn];
end