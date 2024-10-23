function test_P2()
    global rho;
    % Define the range for x1 and x2
    x1 = linspace(0, 3, 100);
    x2 = linspace(-1.5, 3.5, 100);
    
    % Create a grid of x1 and x2 values
    [X1, X2] = meshgrid(x1, x2);
    
    % Compute the function values over the grid by calling the function f
    F = f(X1, X2);
    
    % Create the contour plot for the function
    contour(X1, X2, F); % 20 contour levels
    hold on;
    
    % Add the constraint line: 1 / (x1 + 1/3) - x2 = 1/2
    x1_constraint = linspace(0, 3, 100);
    x2_constraint = 1 ./ (x1_constraint + 1/3) - 1/2;
    plot(x1_constraint, x2_constraint, 'b-', 'LineWidth', 1.5); % Plot the constraint

    Xstar = [1.5, 0.5];
    fprintf('The initial point is [%f, %f]\n', Xstar(1), Xstar(2));
    rho = 0.151;
    for i=1:20
        Xstar = newtonND(@grad, @myhess, Xstar, 1e-3);
        fprintf('i = %d, rho = %f, Optimal [L,K] = [%f, %f]\n', ...
	        i, rho, Xstar(1), Xstar(2))
        rho = 5*rho;  % Increase rho and loop again.
    end
    fprintf('The minimum point is [%f, %f]\n', Xstar(1), Xstar(2));
    plot(Xstar(1), Xstar(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % Mark the point
    fstar = f(Xstar(1), Xstar(2));
    success = 0;
    fail = 0;

    % Verify it is the true minimum
    for i = 1:100
        fv = f(x1_constraint(i), x2_constraint(i));
        if fv > fstar
            success = success + 1;
        else
            fail = fail + 1;
        end
    end
    fprintf('The test success %d times, fail %d times.\n', success, fail);

    
    % Add labels and title
    xlabel('x1');
    ylabel('x2');
    title('Contour plot of objective function and constraint');
    legend('Objective function', 'Constraint', 'Minimum point', 'Location', 'best');
    hold off;