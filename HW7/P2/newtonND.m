function unp1 = newtonND(f, J, u0, tol)
  % This fcn implements ND root finding via Newton's method

  % Do root finding in a loop to prevent infinite loops
  % from nonconvergence
  un = u0;
  for i = 1:25
    fnp1 = f(un);
    Jnp1 = J(un);
    delta = -Jnp1\fnp1;
    unp1 = un+delta;

    % Stopping criterion: check if delta is less than tol
    if norm(delta) < tol    
      fprintf('Terminating after %d iterations because norm(delta) < tol.\n', i)
      return
    end
    
    % Move variables back
    un = unp1;

  end  % end of for loop

  fprintf('Terminated without convergence!\n')
  unp1 = nan(size(u0));

end
