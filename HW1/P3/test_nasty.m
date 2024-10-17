function test_nasty()
    
    % define xo and sigma
    x0 = -1;
    sigma = 4;
    f_handle = @(x)f(x, x0, sigma);

    tol = 1e-3;
    xmax = 10;

    % start values
    a = -xmax;
    c = xmax;
    b = a + (c - a) * 0.618;
    
    % get the minimum point and value
    xs = quadratic_fit(f_handle, a, b, c, tol);
    ys = f_handle(xs);

    % get the true value
    fp_handle = @(x)fp(x, x0, sigma);
    tValue = fsolve(fp_handle, 0);
    ytrue = f_handle(tValue);

    try
        % test the value
        if (abs(xs - tValue))
            % pass
            fprintf('Passed!  xstar = %f, true = %f\n', xs, tValue)
        else
            % fail
            fprintf('Failed!  xstar = %f, true = %f\n', xs, tValue)
        end
    
        % plot the result
        xp = linspace(a, c, 100);
        plot(xp,f_handle(xp),'k-','LineWidth',1);
        hold on;
    
        % Plot the calculated and true minimum points
        scatter(xs, ys, 'b');  % Calculated minimum point
        plot(tValue, ytrue, '*', 'MarkerSize', 10, 'MarkerEdgeColor', 'b');  % True minimum point
        
    
        % Add legend and labels
        legend('f(x)', 'Quadratic Fit Min', 'True Min', 'Location', 'best');
        title('Quadratic Fit vs True Minimum');
        xlabel('x');
        ylabel('f(x)');
        hold off;
        
    catch exception
        disp(exception.message);
        % plot the result
        xp = linspace(a, c, 100);
        plot(xp,f_handle(xp),'k-','LineWidth',1);
        hold on;
        
        % plot the true value
        plot(tValue, ytrue, '*', 'MarkerSize', 10, 'MarkerEdgeColor', 'b');  % True minimum point
        
        % Add legend and labels
        legend('f(x)', 'True Min', 'Location', 'best');
        title('Quadratic Fit vs True Minimum');
        xlabel('x');
        ylabel('f(x)');
        hold off;
    end
end


% the f function
function fx = f(x, x0, sigma)
    fx = 1 - exp(-(x - x0).^2 / sigma);
end

% the f derivative function
function fp = fp(x, x0, sigma)
    fp = 2 * (x - x0) / sigma * exp(-(x - x0)^2 / sigma);
end