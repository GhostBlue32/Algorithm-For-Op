function h = hess0(X)
  % This fcn returns the Hessian matrix for the 
  % quartic example problem.
  x = X(1);
  y = X(2);

  % Now compute the Hessian
  h11 = 3 * x.^2 - 1 + exp(x) / 5;
  h12 = 0;
  h21 = 0;
  h22 = 1;

  h = [h11, h12; h21, h22];  

end
