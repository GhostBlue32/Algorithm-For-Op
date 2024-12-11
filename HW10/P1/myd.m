function dn = myd(xn)
  % Returns the RHS constraint vector at this point.
  % For this example the RHS is a scalar.
    
  x1 = xn(1);
  x2 = xn(2);

  dn = x2 - x1^2 + 1;

end
