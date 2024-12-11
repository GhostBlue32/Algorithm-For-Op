function y = f(x)
  % This is the Dixon-Price fcn in 2D:
  % https://www.sfu.ca/~ssurjano/dixonpr.html
    
  x1 = x(1);
  x2 = x(2);
  beta = 10;
  S1 = (1 + beta) * (x1 - 1) + (2 + beta) * (x2 - 0.5);
  S2 = (1 + beta) * (x1^2 - 1) + (2 + beta) * (x2^2 - 0.25);
  y = S1^2 + S2^2;

end
