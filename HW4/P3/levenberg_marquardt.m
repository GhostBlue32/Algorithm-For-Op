function beta = levenberg_marquardt(rfcnptr, gfcnptr, yi, vi, beta0, tol)
  % This is the implementation of Levenberg-Marquardt for optimization
  % of a nonlinear least-squares fit.  Inputs:
  % rfcnptr = function handle to residual fcn
  % gfcnptr = gradient of r w.r.t. parameters X
  % yi = vector of dependent variables
  % vi = vector of independent variables
  % tol = stopping tolerance

  % Initialize algorithm variables
  N = length(vi);     % Number of (yi, vi) data points
  M = length(beta0);     % Number of parameters
  r = zeros(N, 1);    % Vector of residuals

  J = zeros(N, M);    % NxM Jacobian matrix
  beta = beta0;             % Vector holding parameters
     
  
  lambda = 10;       % Start with something resembling gradient descent

  % Compute error at starting point
  for i = 1:25
    r(i) = rfcnptr(yi(i), vi(i), beta);
  end
  olderr = norm(r);
      
  % Do optimization in a loop to prevent infinite loops
  % from nonconvergence
  for cnt = 1:25
   
    % Assemble the Jacobian matrix
    for i = 1:N                           % Loop over rows in Jacobian
      g = gfcnptr(vi(i), beta);       % Gradient vector
      J(i, :) = g;                        % Assemble Jacobian
    end
    
    % Compute proposed step
    B2 = J'*J;              % Compute the approximate Hessian
    B2diag = diag(diag(B2));
    B = (B2 + lambda*B2diag);
    delta = B\(J'*r);      % Compute step

    % Compute error at the proposed new point and decide what to do    
    % Compute residual vector
    for i = 1:N
      r(i) = rfcnptr(yi(i), vi(i), beta+delta);
    end
    err = norm(r);
    

    if (err < olderr)
      % Error has decreased.  Commit step and act more like Newton
      lambda = lambda/10;
      beta = beta + delta;          % Take step
       
    else
      % Error has increased.  Don't take step.  Rather, act more like
      % gradient descent and try again from this point.
      lambda = lambda*10;
      
    end
    olderr = err;
    
    % Check if we're close enough to quit yet
    % Check if step size delta is less than tol
    if norm(delta) < tol
      fprintf('Terminating after %d iterations because norm(delta) < tol.\n', cnt)
      return
    end
 
  end  % end of for loop

end
