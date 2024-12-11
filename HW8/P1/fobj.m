function z = fobj(u)
  % This is a simple obj fcn to demonstrate projected
  % gradient descent.
    
  x = u(1);
  y = u(2);
  
  z = (x-0.5).^2 + 2 * (y-0.75).^2;

end
