function fx = f(X)
    a = 1.5;
    x1 = X(1);  
    x2 = X(2);  
    fx = -exp(-(x1*x2 - a)^2 - (x2 - a)^2);
end