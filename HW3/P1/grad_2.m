function g = grad_2(X)
  % This function returns the gradient vector for the 
  % 4th power example problem
  x1 = X(1);
  x2 = X(2);

  % Gradient
  g1 = x1 ./ 2;
  g2 = 2 / 9 * x2;
  g = [g1; g2];

end