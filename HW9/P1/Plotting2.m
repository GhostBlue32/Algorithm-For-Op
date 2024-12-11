% Define the range for x1 and x2
x1 = linspace(-2, 8, 100);
x2 = linspace(-2, 8, 100);

% Create a meshgrid for x1 and x2
[X1, X2] = meshgrid(x1, x2);

% Define the function f(x1, x2) = x1 + 2x2
F = 6 * X1 + 4 * X2;

% Create the contour plot for f(x1, x2)
figure;
contour(X1, X2, F, 'LineStyle', '--'); % Dashed contour lines
hold on;

% Plot the line x1 + 3x2 = 6
plot(x1, (1 - x1) / 5, 'b', 'LineWidth', 2); 

% Plot the line 5x1 + x2 = 4
plot(x1, 2 - 3 * x1, 'r', 'LineWidth', 2); 

% Set axis limits for better visualization
xlim([-2, 8]);
ylim([-2, 8]);

% The optimal point
plot(9/14, 1/14, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); 

% Add labels and legend
xlabel('y_1');
ylabel('y_2');
title('P1 plotting');
legend('f(y_1, y_2) = 6y_1 + 4y_2', 'y_1 + 5y_2 = 1', '3y_1 + y_2 = 2', 'optimal point');

% Show the grid
grid on;
hold off;

