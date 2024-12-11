function test_P3()
     % Define the range for x and y
    x = linspace(0, 140, 100);
    y = linspace(0, 140, 100);
    
    % Create a meshgrid for x and y
    [X, Y] = meshgrid(x, y);
    
    % Define the objective function (2010 - 10x)x + (3330 - 25y)y
    Z = (2010 - 10*X).*X + (3330 - 25*Y).*Y;
    
    % Plot the contour of the objective function
    figure;
    contour(X, Y, Z, 20, 'LineStyle', '--');
    hold on;
    
    % Plot the constraints
    % Constraint y = 75
    plot(x, 75 * ones(size(x)), 'b', 'LineWidth', 1.5);
    
    % Constraint x = 95
    plot(95 * ones(size(y)), y, 'b', 'LineWidth', 1.5);
    
    % Constraint x + y = 125
    plot(x, 125 - x, 'b', 'LineWidth', 1.5);
        
    % Labels and title
    xlabel('cars');
    ylabel('trucks');
    title('LP solution to car/truck problem');
    
    % Set axis limits for better visualization
    axis([0 140 0 140]);
    grid on;
    
    % The coeff
    H = [20, 0; 0, 50];
    f = [-2010; -3330];
    A = [0, 1; 1, 0; 1, 1];
    b = [75; 95; 125];
    options = optimoptions('quadprog', 'Display', 'iter');
    [xstar, fval] = quadprog(H, f, A, b, [], [], [], [], [], options);

    %Test the xstar
    pass = 0;
    fail = 0;
    for i=1:95
        xtest = i;
        ytest = 125 - xtest;
        if ytest > 75
            continue
        end
        ptest = (2010-10*xtest)*xtest+(3330-25*ytest)*ytest;
        if ptest < -fval
            pass = pass + 1;
        else
            fail = fail + 1;
        end
    end
    fprintf('Total test is 95, pass test is %d, fail %d times\n',pass, fail);

    % Mark the optimal point
    fprintf('The optimal is [%f, %f]\n',xstar(1), xstar(2));
    fprintf('The maximal profit is fval = %f\n',-fval);
    plot(xstar(1), xstar(2), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
    hold off;
end