function test_P2()
    % Define range for x and y
    x = 0:140;
    y = 0:140;

    % Define the constraints
    y1 = 75 * ones(size(x)); % y = 75
    x1 = 95 * ones(size(y)); % x = 95
    y2 = 125 - x; % x + y = 125
    
    % Plot the constraints
    figure;
    hold on;
    plot(x, y1, 'b', 'LineWidth', 1.5); % y = 75
    plot(x1, y, 'b', 'LineWidth', 1.5); % x = 95
    plot(x, y2, 'b', 'LineWidth', 1.5); % x + y = 125
    
    % Define the objective function lines (parallel to 2000x + 3300y)
    % Objective function: 2000*x + 3300*y = constant
    for c = 0:30:210
        y_obj =  - 2000*x / 3300 + c;
        plot(x, y_obj, ':'); % Dashed lines
    end
    
    % Labels and title
    xlabel('cars');
    ylabel('trucks');
    title('LP solution to car/truck problem');
    axis([0 140 0 140]); % Set axis limits for a better view
    
    % Coeffes
    A = [1, 0; 0, 1; 1, 1];
    b = [95; 75; 125];
    c = [2000; 3300];
    [xstar, fval] = simplex_basic(A, b, c);
    fprintf('The optimal is [%d, %d]\n',xstar(1), xstar(2));
    fprintf('The result is fval = %d\n',fval);

    %Test the xstar
    pass = 0;
    fail = 0;
    for i=1:95
        xtest = i;
        if xtest == xstar(1)
            continue
        end
        ytest = 125 - xtest;
        if ytest > 75
            continue
        end
        ptest = 2000 * xtest + 3300 * ytest;
        if ptest < fval
            pass = pass + 1;
        else
            fail = fail + 1;
        end
    end
    fprintf('Total test is %d, pass test is %d, fail %d times\n', pass + fail,pass, fail);
    
    % Mark the optimal point 
    plot(xstar(1), xstar(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); 
    hold off
end