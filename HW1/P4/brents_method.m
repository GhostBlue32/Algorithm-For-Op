function xstar = brents_method(f, a, b, tol)
  % This implements Brent's method for optimizing a
  % 1D unimodal function.  It needs some polishing, but
  % it conveys the idea ....
  % Inputs:
  % f = handle to obj fcn.
  % a = left bound.
  % b = right bound.
  % tol = stopping tol.
    
  
  % Compute starting values
  psi = (sqrt(5)-1)/2;
  x = a + psi*(b-a); % Golden ratio finds first x.
  
  % Running measure of last step
  sm1 = inf;

  fprintf('=============================\n')
  fprintf('Testing Brents method on new obj fcn.  a = %f, b = %f\n', a, b)
  for cnt = 1:50
  
    % Try to get new point u using SPI.
    fprintf('Iteration %d.  Trying spi ... ', cnt)
    u = spi(f, a, b, x);
    fprintf('u = %f ...',u)
    
    % Check that SPI was well-behaved, and if not set flag to
    % do gss instead.
    do_gss = 0;
    if (isnan(u))
      % spi() told me of a problem.
      fprintf('nan return from spi, do gss\n')
      do_gss = 1;
    end
    
    s = abs(u-x);  % This is the step I just took.
    if (s > sm1/2)
      % My step was too far
      fprintf('step = %e too far, do gss\n', s)      
      do_gss = 1;
    end
    
    % Do GSS step if SPI has failed.
    if (do_gss)
      u = gss(f, a, b, x);
      %fprintf('failed!  Use GSS to take step.  ')
    else
      %fprintf('success!  ')
    end
    
    % Now evaluate f at new points and update boundaries as needed
    fu = f(u);
    fx = f(x);
    
    if (fu <= fx)
      if (u >= x)
	a = x;
	x = u;
      else
	b = x;
	x = u;
      end
    else
      if (u<x)
	a = u;
	x = x;
      else
	b = u;
	x = x;
      end
    end
    
    fprintf('New a = %f, b = %f, x = %f\n', a, b, x)
    
    % Check for convergence
    if ((b-a)<tol)
      fprintf('Converged at iteration %d!\n', cnt)      
      xstar = u;
      return
    end

    % Move variables back to prepare for next loop iteration.
    sm1 = s;
    
  end
  % If we get here, it's because the method did not converge.
  error('Brents method failed to converge!')
  
end
  