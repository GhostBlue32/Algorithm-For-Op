function ustar = newton_eq(f, g, h, C, d, X0)
  % Finds optimum point of constrainted obj fcn f using
  % Newton's method.  Inputs:
  % f = obj fcn.
  % g = gradient
  % h = Hessian
  % C = 
  % d = constraint values
  % X0 = initial guess of form [x1;x2;lam]

  tol = 1e-4;
    
  xn = X0(1:2)
  lamn = X0(3)
  
  for cnt = 1:100

    fprintf('---------  cnt = %d  -----------\n', cnt)
    
    % Compute obj, grad, Hessian.
    fn = f(xn);
    gn = g(xn);
    hn = h(xn);

    % Compute linearized constraints at this point
    Cn = C(xn);
    dn = d(xn);
    
    % Assemble RHS vector and KKT matrix
    vn = [-gn;
	  -dn];
    Mn = [hn, Cn';
	  Cn, 0];
    
    % Take step
    un = [xn;lamn];
    unp1 = un + Mn\vn;

    fprintf('unp1 = \n')
    disp(unp1)
    
    % Extract x and lambda.
    xnp1 = unp1(1:2);
    lamnp1 = unp1(3);

    % Check for convergence
    if (norm(xnp1-xn) < tol)
      ustar = unp1;
      return
    end

    % Move variables back.    
    xn = xnp1;
    lamn = lamnp1;
    
  end
  error('newton_eq terminated without convergence!')
  
end

  