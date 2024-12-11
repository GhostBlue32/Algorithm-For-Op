function z = fobj1(u)
  % This is a simple obj fcn to demonstrate projected
  % gradient descent.
    
  x = u(1);
  y = u(2);
  
  z = (x-2).^2 + 2 * (y-1.5).^2;

end
