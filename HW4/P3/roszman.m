function y = roszman(x, beta)
  
    
  y = beta(1) - beta(2) * x - 1 / pi * atan(beta(3) ./ (x - beta(4)));
end