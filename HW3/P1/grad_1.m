function g = grad_1(X)
  % This function returns the gradient vector for the 
  % 4th power example problem
  x1 = X(1);
  x2 = X(2);

  % Gradient
  g1 = x1.^3;
  g2 = 4 * x2.^3 / 9;
  g = [g1; g2];

end