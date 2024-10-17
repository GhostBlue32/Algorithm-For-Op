function test_newton_f()

  

  global lim
  lim = 5;
  
  %startpt = [30; 50];
  X = [2; 2];
  startpt = X;
  

  N = 250;
  figure(1)
  x = linspace(lim, -lim, N);
  y = linspace(lim, -lim, N);
  [xm, ym] = meshgrid(x, y);
  for r = 1:N; for c = 1:N
    % Do plot of log(1+fcn) since its contours are much more clear
    zm(r, c) = log( 1+f([xm(r,c), ym(r,c)]) );
  end; end;
  contour(xm, ym, zm, 30);
  hold on
  
  f_fail = 0;
  f_success = 0;
  epsilon = 1e-5;
    eps = [epsilon, epsilon];
    for x0 = -5:1:5
        for y0 = -5:1:5
            X0 = [x0; y0];
            X_re = newton_optimizer(@f, @lgrad, @hess0, X0, 1e-5);
            
            if f(X_re) < f(X_re + eps) && f(X_re) < f(X_re - eps)
                fprintf('Startpoint (%d, %d). Found the minimum, the point is (%f, %f)\n', x0, y0, X_re(1), X_re(2));
                f_success = f_success + 1;
            else
                fprintf('Startpoint (%d, %d). Failed, the point is (%f, %f)\n', x0, y0, X_re(1), X_re(2));
                f_fail = f_fail + 1;
            end
            plot(X_re(1), X_re(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
        end
    end

    
  fprintf('f_fail =%d, f_success = %d\n', f_fail, f_success);
  % Find the minimum using Matlab fminsearch
  options = optimset('TolX', 1e-5, 'TolFun', 1e-6);
  [min_point, min_value] = fminsearch(@f, startpt, options);
    if f(min_point) <= f(min_point + eps) && f(min_point) < f(min_point - eps)
          fprintf('Matlab found the minimum, the point is (%f, %f)\n', min_point(1), min_point(2));
    else
          fprintf('Matlab failed, the point is (%f, %f)\n', min_point(1), min_point(2));
    end
  

end
