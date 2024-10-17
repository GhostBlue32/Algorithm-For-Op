function xstar = quadratic_fit(f, a, b, c, tol)
  % This is the quadratic fit algo.  It is not a 
  % direct port of the algo in the textbook -- I follow
  % the algo presented in class (i.e. using linear solve).
  % This is sometimes called "successive parabola interpolation".
  % This variant also removes the last interpolation point
  % instead of doing bracketing.  It makes no assumptions about
  % the positions of the three points.
  % This function accepts the following input:
  % f = handle to objective function.
  % a
  % b
  % c
  % tol = stopping tol.

  warning('off','MATLAB:nearlySingularMatrix');

  % Sample objective function at three points.
  ya = f(a);
  yb = f(b);
  yc = f(c);

  % Use for loop instead of while loop to prevent infinite loops.
  for i=1:100
    % Solve Vandermonde system to get coeffs of fitted parabola.
    y = [ya; yb; yc];
    A = [1, a, a^2; 1, b, b^2; 1, c, c^2];
    p = A\y;

    % This is minimum of parabola.
    x = -p(2)/(2*p(3));
    yx = f(x);

    % Check for convergence.  Specifically, check that the values
    % of new point x and the previous new point c are close together
    if (abs(x - c) < tol)
      fprintf('Converged!\n')
      xstar = x;
      return
    end

    % Now figure out new three points by just
    % removing the "oldest" point (a).
    a = b;
    ya = yb;
    b = c;
    yb = yc;
    c = x;
    yc = yx;
    
  end  % for i=
  % If we get here it's because we did not converge.  Error out.
  xstar = x;
  
end
  
  