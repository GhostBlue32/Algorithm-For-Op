function h = myhess(X)
  x1 = X(1);
  x2 = X(2);
  beta = 10;
  S1 = (1 + beta) * (x1 - 1) + (2 + beta) * (x2 - 0.5);
  S2 = (1 + beta) * (x1^2 - 1) + (2 + beta) * (x2^2 - 0.25);
  h = zeros(2,2);
  h(1,1) = 2 * (1 + beta)^2 + 8 * (1 + beta)^2 * x1^2 + 4 * (1 + beta) * S2;
  h(1,2) = 2 * (1 + beta) * (2 + beta) + 8 * (1 + beta) * (2 + beta) * x1 * x2;
  h(2,1) = h(1,2);
  h(2,2) = 2 * (2 + beta)^2 + 8 * (2 + beta)^2 * x2^2 + 4 * (2 + beta) * S2;
 
end
