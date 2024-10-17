function test_newton_f()

    %startpt = [30; 50];
    X = [1; 1];
    startpt = X;
    
    
    N = 250;
    figure(1)
    x = linspace(-1, 4, N);
    y = linspace(-1, 4, N);
    [xm, ym] = meshgrid(x, y);
    for r = 1:N; for c = 1:N
    % Do plot of log(1+fcn) since its contours are much more clear
    zm(r, c) = f([xm(r,c), ym(r,c)]) ;
    end; end;
    contour(xm, ym, zm, 50);
    hold on
    
    % The success end point and the success startpoint
    X_sus = -1 * ones(6, 2);
    x_sus = -1 * ones(6, 2);
    
    f_fail = 0;
    f_success = 0;
    epsilon = 1e-5;
    eps = [epsilon, epsilon];
    for x0 = 0:1:4
        for y0 = 0:1:4
            X0 = [x0; y0];
            X_re = newton_optimizer(@(X) f(X), @(X) lgrad(X), @(X) hess0(X), X0, 1e-5);
            
            if f(X_re) < f(X_re + eps) && f(X_re) < f(X_re - eps)
                fprintf('Startpoint (%d, %d). Found the minimum, the point is (%f, %f)\n', x0, y0, X_re(1), X_re(2));
                f_success = f_success + 1;
                X_sus(f_success, :) = X_re;
                x_sus(f_success, :) = [x0, y0];
            else
                fprintf('Startpoint (%d, %d). Fail to find the minimum, the point is (%f, %f)\n', x0, y0, X_re(1), X_re(2));
                f_fail = f_fail + 1;
            end
            
        end
    end

   
    fprintf('f_fail =%d, f_success = %d\n', f_fail, f_success);
    for i = 1:f_success
        plot(x_sus(i, 1), x_sus(i, 2), 'yo','MarkerFaceColor','y','MarkerSize',5)
        fprintf('Startpoint (%d, %d). Found the minimum, the point is (%f, %f)\n', x_sus(i, 1), x_sus(i, 2), X_sus(i, 1), X_sus(i, 2));
        plot(X_sus(i, 1), X_sus(i, 2), 'ro','MarkerFaceColor','r','MarkerSize',10)
    end
    % Find the minimum using Matlab fminsearch
    options = optimset('TolX', 1e-5, 'TolFun', 1e-6);
    [min_point, min_value] = fminsearch(@f, startpt, options);
    if f(min_point) <= f(min_point + eps) && f(min_point) < f(min_point - eps)
        fprintf('Matlab found the minimum, the point is (%f, %f)\n', min_point(1), min_point(2));
    else
        fprintf('Matlab failed, the point is (%f, %f)\n', min_point(1), min_point(2));
    end
  

end
