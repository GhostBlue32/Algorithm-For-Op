function test_P3()
    % This covers the design space with a grid and then
    % uses the "dominates" predicate to color the points
    % to trace out the Pareto optimal points in both 
    % design and objective space.

    % Define the objective functions
    fun = @(x)[f1(x(1), x(2)); f2(x(1), x(2))];

    % Create points in the design space
    N = 60;
    xv = linspace(-3, 3, N);
    yv = linspace(-3, 3, N);
    [Xm, Ym] = meshgrid(xv, yv);

    % Plot the objective space
    figure(2);
    hold on;
    for i = 1:N
        for j = 1:N
            % Compute both objective functions at grid points
            f1ij = f1(Xm(i, j), Ym(i, j));
            f2ij = f2(Xm(i, j), Ym(i, j));
            plot(f1ij, f2ij, 'g.');
        end
    end
    xlabel('f1');
    ylabel('f2');
    title('Objective Space');
    xlim([-10, 60]);
    ylim([-5, 35]);

    % Now double loop over points in design space and 
    % find points x which correspond to non-dominating points.
    saveidx = [];
    % Do linear indexing here.
    for i1 = 1:N*N
        p1 = [Xm(i1),Ym(i1)];
        for i2 = 1:N*N
            p2 = [Xm(i2),Ym(i2)];
            if dominates(p2,p1,@f1,@f2)
                % p2 dominates p1.
                dom = true;
                break
            else
                % p1 not dominated
                dom = false;
            end
        end
        if (dom == false)
        % Point p1 is non-dominated.  Record it.
        saveidx = [saveidx, i1];
        end
    end
  
    %fprintf('saveidx = ')
    %disp(saveidx)
  
    for i = 1:length(saveidx)
        idx = saveidx(i);
        x = Xm(idx);
        y = Ym(idx);
        %fprintf('Plotting Pareto optimal point [%f, %f]\n', x, y)
        plot(f1(x,y),f2(x,y),'ro','MarkerFaceColor','r','MarkerSize',5)
    end

    % This is a hack to create the legend.  Just replot the last
    % values with DisplayName to make the legend.
    plt1 = plot(f1(x,y),f2(x,y),'ro','MarkerFaceColor','r','MarkerSize',5, ...
       'DisplayName','gridmethod');
  


    % gamultiobj method
    % Optimization options
    options = optimoptions('gamultiobj', ...
        'PopulationSize', 200, ...    
        'MaxGenerations', 300, ...
        'Display', 'final');

    % Perform multi-objective optimization
    [x, fval] = gamultiobj(fun, 2, [], [], [], [], [-3, -3], [3, 3], [], options);

    % Plot Pareto optimal points in the objective space
    for i = 1:size(fval, 1)
        plot(fval(i, 1), fval(i, 2), 'b*', 'MarkerFaceColor', 'b', 'MarkerSize', 5);
    end

     % This is a hack to create the legend.  Just replot the last
     % values with DisplayName to make the legend.
    plt2 = plot(fval(i, 1),fval(i, 2),'b*','MarkerSize',8, ...
       'LineWidth', 1.5, 'DisplayName','genetic algorithm');
    legend([plt1, plt2], 'Location', 'best');
    title('Objective Space')
end
