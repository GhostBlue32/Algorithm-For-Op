function z = gobj1(u)
  % This is the gradient of the obj fcn.
    
  x = u(1);
  y = u(2);
  
  z = zeros(2,1);
  z(1) = 2*(x-2);
  z(2) = 4*(y-1.5);

end
