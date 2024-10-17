function test_P1()
    start = rand(2, 1) * 5;
    tol = 1e-5;
    xend = coord_search(@f, start, tol);

    %Plot the result
    N = 100;
    xv = linspace(-5,5,N);
    yv = linspace(-5,5,N);  
    [Xm,Ym] = meshgrid(xv,yv);
    Zm = f(Xm,Ym);
    contour(Xm, Ym, Zm, 25)
    hold on
    xlabel('x')
    ylabel('y')
    plot(xend(1), xend(2), 'bo', 'MarkerFaceColor', 'b')
    plot(start(1), start(2), 'ro', 'MarkerFaceColor', 'r')
    legend('function', 'startpoint', 'endpoint', 'Location', 'northwest')

    %test
    epsilon = 1e-4;
    success = 0;
    fail = 0;
    fend = f(xend(1), xend(2));
    for i = 1:100
        % Generate a random angle between 0 and 2*pi radians
        theta = 2 * pi * rand;

        % Convert the angle to x and y components (unit vector)
        x = cos(theta);
        y = sin(theta);
        test_an = xend + [x; y] * epsilon;
        f1 = f(test_an(1), test_an(2));
        if f1 < fend
            fail = fail + 1;
        else
            success = success + 1;
        end
    end
    fprintf('The test success %d times, fail %d times\n', success,fail);
end
