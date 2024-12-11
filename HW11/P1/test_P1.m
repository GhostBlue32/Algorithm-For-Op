function test_P1()
    % contour plot f1
    x = linspace(-3, 3, 100);
    y = linspace(-3, 3, 100);
    [X, Y] = meshgrid(x, y);
    Z1 = arrayfun(@f1, X, Y);
    
    % contour plot f1
    figure;
    contour(X, Y, Z1, 20);
    hold on
    xlabel('x');
    ylabel('y');

    % contour plot f2
    Z2 = arrayfun(@f2, X, Y);
    contour(X, Y, Z2, 20);

    for i = 0:0.1:1
        xstar = opt(i);
        plot(xstar(1), xstar(2), 'ro', 'MarkerFaceColor', 'r')
        fprintf('The motimal for lambda = %f is [%f, %f]\n', i, xstar(1), xstar(2))
    end
    title('Optimal points in design space')
    hold off
end