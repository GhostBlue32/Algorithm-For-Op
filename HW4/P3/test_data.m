function test_data()
    % data
    % X values
    x = [-4868.68, -4868.09, -4867.41, -3375.19, -3373.14, -3372.03, -2473.74, ...
         -2472.35, -2469.45, -1894.65, -1893.40, -1497.24, -1495.85, -1493.41, ...
         -1208.68, -1206.18, -1206.04, -997.92, -996.61, -996.31, -834.94, ...
         -834.66, -710.03, -530.16, -464.17];
    
    % Y values
    y = [0.252429, 0.252141, 0.251809, 0.297989, 0.296257, 0.295319, 0.339603, ...
         0.337731, 0.333820, 0.389510, 0.386998, 0.438864, 0.434887, 0.427893, ...
         0.471568, 0.461699, 0.461144, 0.513532, 0.506641, 0.505062, 0.535648, ...
         0.533726, 0.568064, 0.612886, 0.624169];
    x = x';
    y = y';
    beta0 = [1e-1; -1e-5; 1e+3; -1e+2];
    %beta0 = [2e-1; -5e-6; 1.2e+3; -1.5e+2];
    tol = 1e-5;
    beta1 = levenberg_marquardt(@r, @g, y, x, beta0, tol);
    fprintf('Beta is %8f, %8f, %8f, %8f', beta1(1), beta1(2), beta1(3), beta1(4));
    x_plot = linspace(-5000, -500, 200);
    
    y_plot = roszman(x_plot, beta1);
    
    figure;
    plot(x_plot, y_plot, 'b-', 'LineWidth', 2);
    hold on;
    scatter(x, y, 'ro');
    xlabel('x');
    ylabel('y');
    title('Data Fit using Levenberg-Marquardt Optimization');
    legend('Fitted Model', 'Data Points');
end