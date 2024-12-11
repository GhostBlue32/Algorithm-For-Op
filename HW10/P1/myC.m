function Cn = myC(xn)
  % Returns the constraint matrix at this point.
    
  x1 = xn(1);
  x2 = xn(2);
  Cn = [-2 * x1, 1];

end
