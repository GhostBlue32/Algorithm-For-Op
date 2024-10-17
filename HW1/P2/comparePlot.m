function comparePlot(f, fp, x, hvec)
    % f is the function and fp is the analytic result
    % x is the value, hvec contains the h step size, must be a vector
    
    % set up 
    fDif = zeros(size(hvec)); % forward difference vector
    cDif = zeros(size(hvec)); % central difference vector
    tvalue = fp(x); % true diference value
    
    % set up the tolerance
    tol = 1e-5;

    % calculate the forward difference, including test
    for i = 1: length(hvec) 
        h = hvec(i);
        fDif(i) = abs(forward(f, x, h) - tvalue);

        % test if it is under tolerance
        if (fDif(i) < tol)
            % test pass
            fprintf('Passed, forward dif = %f, true = %f, step is %f\n', forward(f, x, h), tvalue, hvec(i))
        else 
            % test fail
            fprintf('Failed, forward dif = %f, true = %f, step is %f\n', forward(f, x, h), tvalue, hvec(i))
        end
    end
    
    % calculate the central difference, including test
    for i = 1:length(hvec) 
        h = hvec(i);
        cDif(i) = abs(central(f, x, h) - tvalue);

        % test if it is under tolerance
        if (cDif(i) < tol)
            % test pass
            fprintf('Passed, central dif = %f, true = %f, step is %f\n', central(f, x, h), tvalue, hvec(i))
        else 
            % test fail
            fprintf('Failed, central dif = %f, true = %f, step is %f\n', central(f, x, h), tvalue, hvec(i))
        end
    end

    % plot the forward and central difference
    loglog(hvec, fDif, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); 
    hold on;
    loglog(hvec, cDif, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b'); 
    
    % add labels, legend and title
    legend('fwd diff', 'mid diff', 'Location', 'northwest');
    xlabel('h');
    ylabel('err');
    title('Finite difference err vs. stepsize h');
