function res = r(yi, x, beta)
  % This returns the residual (yi - lorentz(vi, A, v0, w))
   
  res = yi - roszman(x, beta);
end
