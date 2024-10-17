function ustar = mygd( x, u0, tol )
  % My version of the gradient descent algorithm.
  % aim at solving the weibull distribution
  %
  % Inputs:
  % u0 -- starting point for iteration u0 = [k0, l0]
  % tol -- stopping tolerance.
  %
  % Outputs:
  % ustar -- approximate minimum point found by iteration

  eta = .00002;
    
  % Start point
  un = u0;
    
  % Do this in for loop -- not while loop -- since it might not converge.
  cnt = 0;
  for idx = 1:10000
    % Get grad.  
    [pk, pl] = L_grad(x, un(1), un(2));
    gn = [sum(pk), sum(pl)];
    cnt = cnt + length(x);

    % For MLE, we want to maximize the objective fcn.  That means
    % we take steps in the direction of the gradient.
    step = eta*gn;
    unp1 = un + step;

    % I use a measure of step size to determine convergence here.
    % Perhaps could use a better measure of convergence, but this
    % seems to work.
    if (norm(step) < tol)
      fprintf('Converged in %d steps.\n', idx)
      fprintf('Number of gradient computations = %d.\n', cnt)
      ustar = unp1;
      return
    end

    % Move variables back one step for next iteration.
    un = unp1;
  end
  ustar = unp1;
  % If we get here it's because the algorithm didn't converge.
  %error('mygd failed to converge!');
end

