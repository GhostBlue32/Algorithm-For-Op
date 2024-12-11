function test_p1()
    tol = 1e-3;
    % Generate a random x value between -1 and 1
    x = -1 + 2 * rand();
    
    % Generate a random y value between -2 and 2
    y = -2 + 4 * rand();
    startpt = [x; y];
    figure(1);
    make_plot(@fobj);
    xstar = projected_gradient_descent(@fobj, @gobj, startpt, tol);
    fprintf('Found minimum xstar = [ %f; %f ]\n', xstar(1), xstar(2))

    figure(2);
    make_plot(@fobj1)
    xstar = projected_gradient_descent(@fobj1, @gobj1, startpt, tol);
    fprintf('Found minimum xstar = [ %f; %f ]\n', xstar(1), xstar(2))
    hold off
end