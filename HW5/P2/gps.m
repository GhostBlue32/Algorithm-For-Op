function ustar = gps(f, u0, D, alpha0, tol)
  % Generalized pattern search algo for minimization of a 2D fcn per
  % section 7.4 of textbook.
  %
  % Inputs:
  % f = objective function handle.  Inputs 3 element vector, outputs scalar.
  % u0 = initial guessed design variable.  3 element col vector.
  % D = 3xN template matrix.  The col vectors are the positive span set.
  % alpha0 = Initial size of search template.  Scalar.
  % tol = convergence tolerance.  Positive scalar.
  %
  % Output:
  % ustar = optimal point.  2 element col vector.
  % 
  % This example assumes the search space is 3D.

  u = u0;
  a = alpha0;

  % Make plot of initial position
  x = u(1);
  y = u(2);
  z = u(3);
  fmin = f([x, y, z]);
    
  for cnt = 1:100
    unew = u;
    % Iterate over pos span set, compute function for step in each direction
    for i=1:size(D,2)
        dx = a*D(1,i);
        dy = a*D(2,i);
        dz = a*D(3,i);
        xnew = [x+dx, y+dy, z+dz];
        fnew = f(xnew);
        if (fnew<fmin)
	        % New lowest point found.  Save it.
	        % fprintf('New lowest point found, [x,y] = [%f, %f]\n', x+dx, y+dy)
	        unew = u + [dx;dy;dz];
	        fmin = fnew;
        end
    end
    
    % Check if u has not moved, then check for convergence.
    if (unew == u)
        % We have not moved.  Check for convergence
        if (a < tol)
	    % Converged
	        ustar = unew;
            fprintf('Lowest point found after %d iteration, [x,y,z] = [%8f, %8f, %8f]\n', i, ustar(1), ustar(2), ustar(3))
	        return
        else
	        % Not moved, not converged.  Shrink a and continue.
	        a = a/2;
        end
    else
        % We moved.  Update position with new value.
        u = unew;
    end

    % Compute fcn value at new anchor point.
    u = unew;
    x = u(1);
    y = u(2);
    z = u(3);
    unew = [x, y, z];
    fmin = f(unew);  % Place min pt at anchor.

    
    
  end
  ustar = unew;
end
