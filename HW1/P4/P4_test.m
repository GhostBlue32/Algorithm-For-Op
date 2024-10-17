function P4_test()
  
  tol = 1e-5;
  pass = 0;
  fail = 0;
  
  %=========================================================
  % First nice fcn.
  x0 = 5;
  sigma = 3;
  f = @(x)f1(x, x0, sigma);
  a = -10;
  b = 10;
  
  x = linspace(a, b, 100);
  figure(1)
  plot(x, f(x), 'b');
  hold on;
  title('f = xtanh((x-x0)/\sigma)')
  
  xstar = brents_method(f, a, b, tol);
  plot(xstar, f(xstar), 'ro')
  legend('f(x)','Minimum point')
  
  % use fsolve to find the true value and test
  fp_handle = @(x)f1p(x, x0, sigma);
  xtrue = fsolve(fp_handle, 0);
  diff = xstar-xtrue;
  fprintf('Testing nice function, diff = %e ... ', diff)
  if (abs(diff)<tol)
    fprintf('Test passed!\n')
    pass = pass+1;
  else
    fprintf('Test failed!\n')
    fail = fail+1;
  end
  
  %=========================================================
  % Second test fcn.
  x0 = -1;
  sigma = 4;
  f = @(x) f2(x, x0, sigma);
  a = -10;
  b = 10;
  
  x = linspace(a, b, 100);
  figure(2)
  plot(x, f(x), 'b');
  hold on;
  title('f = 1-exp(-(x-x_0)^2/\sigma)')
  
  xstar = brents_method(f, a, b, tol);
  plot(xstar, f(xstar), 'ro')
  legend('f(x)','Minimum point')

  % use fsolve to find the true value and test
  fp_handle = @(x)f2p(x, x0, sigma);
  xtrue = fsolve(fp_handle, 0);
  diff = xstar-xtrue;
  fprintf('Testing nasty function, diff = %e ... ', diff)
  if (abs(diff)<tol)
    fprintf('Test passed!\n')
    pass = pass+1;
  else
    fprintf('Test failed!\n')
    fail = fail+1;
  end
  

  %=========================================================
  fprintf('At end of testing, pass = %d, fail = %d\n', pass, fail)
  
end


% the nice function
function f1x = f1(x, x0, sigma)
    f1x = x .* tanh((x - x0) / sigma);
end

% the nice derivative function
function f1p = f1p(x, x0, sigma)
    f1p = tanh((x- x0) / sigma) + x / sigma * (1 - tanh((x - x0) / sigma) ^ 2);
end

% the nasty function
function f2x = f2(x, x0, sigma)
    f2x = 1 - exp(-(x - x0).^2 / sigma);
end

% the nasty derivative function
function f2p = f2p(x, x0, sigma)
    f2p = 2 * (x - x0) / sigma * exp(-(x - x0)^2 / sigma);
end
  