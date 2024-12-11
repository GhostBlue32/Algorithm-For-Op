function Xnp1 = projected_gradient_descent(lfcn, lgrad, X0, tol)
  % Simple example of projected gradient descent used in class
  % demo.

  alpha = 0.1;
    
  % Initialize algorithm and display starting point.
  Xn = X0;
  fprintf('start Xn = [%8.5f, %8.5f]\n', Xn(1), Xn(2) ); 
  h = plot(Xn(1), Xn(2), 'ro','MarkerSize',10,'MarkerFaceColor','r');

  % Do optimization in a loop to prevent infinite loops
  % from nonconvergence
  for i = 1:1000
    % Get the gradient at point X.  This is the direction to step in.
    gn = lgrad(Xn);

    % Use fixed step size alpha to take step.
    delta = alpha*gn;

    % Update Xn
    Xnp1 = Xn - delta;

    % Plot Proposed position

    % Check that we're in the feasible region
    if (Xnp1(1) < -1)
      % Nope -- project onto feasible region
      Xnp1(1) = -1;
    end
    if (Xnp1(1) > 1)
        Xnp1(1) = 1;
    end
    if (Xnp1(2) < -2)
      % Nope -- project onto feasible regsion
      Xnp1(2) = -2;
    end
    if (Xnp1(2) > 2)
      % Nope -- project onto feasible regsion
      Xnp1(2) = 2;
    end
    
    
    % Check if we're close enough to quit yet
    if norm(Xn - Xnp1) < tol
      fprintf('Terminating after %d iterations because norm(delta) < tol.\n', i)
      plot(Xnp1(1), Xnp1(2), 'bo','MarkerSize',10,'MarkerFaceColor','b');
      return
    end

    % Move variables back.
    Xn = Xnp1;
    
  end  % end of for loop

error('Terminated without convergence!\n')
end
