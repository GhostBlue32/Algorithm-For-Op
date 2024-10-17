function xnp1 = gradient_descent_polyak_momentum(lfcn, lgrad, X0, tol)
  % Gradient descent using Polyak momentum.  This follows the text, 
  % eqs 5.19, 5.20.

  % Momentum parameter.
  beta = 0.9;

  % Step size parameter
  alpha = .01;

  % Stopping parameter
  epsr = tol;
  
  % Initialize algorithm and display starting point.
  xn = X0;      % Initial point
  vn = [0,0];   % Initial momentum
  fn = lfcn(xn);  
  
  % Do optimization in a loop to prevent infinite loops
  % from nonconvergence
  for i = 1:100
    % Get the gradient at point xn.  This is (opposite) 
    % the direction to step in.
    gn = lgrad(xn);

    % Compute velocity 
    vnp1 = beta*vn - alpha*gn;


    % Compute new point
    xnp1 = xn +  vnp1;
    
    
    % Plot new position
    %figure(figno)
    %plot(xnp1(1), xnp1(2), 'ro')

    % Check stopping criterion.  We use relative improvement
    % and small steps as a stopping criterion here.
    fnp1 = lfcn(xnp1);
    rel_improvement = (norm(lgrad(xnp1)) < tol * (1 + abs(lfcn(xnp1))));
    delta = xnp1-xn;
    stepsize = (norm(delta) < tol);
    if (rel_improvement && stepsize)
      fprintf('Successfully terminating after %d iterations.\n', i)
      return
    end
   
    % Replace old values with new ones
    xn = xnp1;
    vn = vnp1;
    fn = fnp1;
    
    %fprintf('Hit any key to step again....\n')
    %pause
 
  end  % end of for loop

%error('Terminated without convergence!\n')
end
