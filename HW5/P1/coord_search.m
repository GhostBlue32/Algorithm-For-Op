function pstar = coord_search(f, p0, tol)
  % Inputs:
  % f = obj fcn
  % p0 = intial guess point.
  % tol = stopping tol
  % Outputs:
  % pstar = minimum
  %
  % For simplicity, the objective fcn is assumed to be a 
  % fcn of two inputs, f(x, y).  For the general case (N inputs)
  % indexing becomes more complicated.
    
  xn = p0(1);
  yn = p0(2);
  fprintf('Start point is [%f, %f]\n', xn, yn);
  
  
    
  % Loop: search over all coords.
  % Use "for" loop to prevent infinite looping.
  for i = 1:100
    
    % First create lambda to search on x.  Use x as starting guess.
    f1 = @(xi) f(xi,yn);
    % Search on x
    xnp1 = fminsearch(f1, xn);
    
    
    
    
      % Now create lambda to search on y.  Use y as starting guess.
    f2 = @(yi) f(xnp1, yi);
    % Search on y
    ynp1 = fminsearch(f2, yn);
     
    
      
    % Check for convergence by checking if step is small enough.
    if (norm([xnp1-xn, ynp1-yn]) < tol)
      % Converged
      pstar = [xnp1;ynp1];
      fprintf('Converged after %d iterations.  pstar = [%f, %f].\n', i, pstar(1), pstar(2))
      return
    else
      xn = xnp1;
      yn = ynp1;
    end
    
  end
  pstar = [xnp1; ynp1];
  % If we get here, it's because we exceeded the allowed number of
  % iterations.
  
end