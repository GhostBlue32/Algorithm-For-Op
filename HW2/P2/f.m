function fx = f(X)
    x = X(1);  
    y = X(2);  
    fx = x.^4 ./ 4 - x.^2 ./ 2 + x ./ 10 + y.^2 ./ 2 + exp(x) ./ 5;
end