function X = newton_optimizer(lfcn, lgrad, lhess, X0, tol)
  % This is the implementation of Newton's method for optimizing a scalar
  % fcn having multiple inputs.  This version computes the step
  % directly.

   
  c1 = .6;
  X = X0;
  fprintf('start X = [%8.5f, %8.5f]\n', X(1), X(2) ); 
  plot(X(1), X(2), 'bo','MarkerFaceColor','b','MarkerSize',5)
  hold on
  

  % Do optimization in a for loop to prevent infinite loops
  % from nonconvergence
  for i = 1:100

    % Compute the fcn here
    fx = lfcn(X);

    % Now get the gradient at point X
    gn = lgrad(X);

    % Now get the Hessian at point X
    Hn = lhess(X);
    if (i == 1)
        eig(Hn)
    end
    if rcond(Hn) < 1e-12
        fprintf('Hessian matrix is close to singular, exiting after %d iterations.\n', i);
        return;
    end
    % Get step vector
    pn = -Hn\gn;
    

    % Find min along the direction pointed by pn.  I use
    % a Matlab built-in fcn to do the line search.
    
    
    
    % Update X by stepping in direction pn with stepsize delta*pn.
    X = X + pn;

    m = @(t) lfcn(X + t*pn);
    delta = fminsearch(m, 1);
    
    
    
    % Backtracking is done.  Now update X by
    % stepping in direction pn
    X = X + delta*pn;

    

  end  % end of for loop

  
end
