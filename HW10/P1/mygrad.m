function g = mygrad(x)
  x1 = x(1);
  x2 = x(2);
  beta = 10;
  S1 = (1 + beta) * (x1 - 1) + (2 + beta) * (x2 - 0.5);
  S2 = (1 + beta) * (x1^2 - 1) + (2 + beta) * (x2^2 - 0.25);
  g = zeros(2,1);
  g(1) = 2 * (1 + beta) * S1 + 4 * (1 + beta) * x1 * S2;
  g(2) = 2 * (2 + beta) * S1 + 4 * (2 + beta) * x2 * S2;

end

