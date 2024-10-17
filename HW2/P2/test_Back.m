function test_Back()

    % Draw the contour plot
    lim = 5;
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

    % All the integer in blue
    [x_int, y_int] = meshgrid(-5:1:5, -5:1:5);
    plot(x_int, y_int, 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'b');
    title('Aluffi-Pentini function and minimum point', 'FontSize', 16, 'FontWeight', 'bold');
    xlabel('x');
    ylabel('y');
    
    epsilon = 1e-5;
    eps = [epsilon, epsilon];
    for x0 = -5:1:5
        for y0 = -5:1:5
            X0 = [x0, y0];
            X_re = gradient_descent_back(@f, @lgrad, X0, 1e-5);
            %X_re = gradient_descent_nesterov_momentum(@f, @lgrad, X0, 1e-5);
            %X_re = gradient_descent_polyak_momentum(@f, @lgrad, X0, 1e-5);
            if f(X_re) < f(X_re + eps) && f(X_re) < f(X_re - eps)
                fprintf('Startpoint (%d, %d). Found the minimum, the point is (%f, %f)\n', x0, y0, X_re(1), X_re(2));
            else
                fprintf('Startpoint (%d, %d). Failed, the point is (%f, %f)\n', x0, y0, X_re(1), X_re(2));
            end
            plot(X_re(1), X_re(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
        end
    end


    % Minimum using matlab
    options = optimset('TolX', 1e-5, 'TolFun', 1e-5);
    initial_guess = [0, 0];
    [min_point, min_value] = fminsearch(@f, initial_guess, options);
    if f(min_point) <= f(min_point + eps) && f(min_point) < f(min_point - eps)
          fprintf('Matlab found the minimum, the point is (%f, %f)\n', min_point(1), min_point(2));
    else
          fprintf('Matlab failed, the point is (%f, %f)\n', min_point(1), min_point(2));
    end    
end

