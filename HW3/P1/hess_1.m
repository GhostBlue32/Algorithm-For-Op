function h = hess_1(X)
  % This fcn returns the Hessian matrix for the 
  % quartic example problem.
  x1 = X(1);
  x2 = X(2);

  % Now compute the Hessian
  h11 = 3 * x1.^2;
  h12 = 0;
  h21 = 0;
  h22 = 4 * x2.^2 / 3;

  h = [h11, h12; h21, h22];  

end
