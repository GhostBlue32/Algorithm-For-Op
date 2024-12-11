% Define the range for x1 and x2
x1 = linspace(-2, 8, 100);
x2 = linspace(-2, 8, 100);

% Create a meshgrid for x1 and x2
[X1, X2] = meshgrid(x1, x2);

% Define the function f(x1, x2) = x1 + 2x2
F = X1 + 2 * X2;

% Create the contour plot for f(x1, x2)
figure;
contour(X1, X2, F, 'LineStyle', '--'); % Dashed contour lines
hold on;

% Plot the line x1 + 3x2 = 6
plot(x1, (6 - x1) / 3, 'b', 'LineWidth', 2); 

% Plot the line 5x1 + x2 = 4
plot(x1, 4 - 5 * x1, 'r', 'LineWidth', 2); 

% Set axis limits for better visualization
xlim([-2, 8]);
ylim([-2, 8]);

% The optimal point
plot(3/7, 13/7, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); 

% Add labels and legend
xlabel('x_1');
ylabel('x_2');
title('P1 plotting');
legend('f(x_1, x_2) = x_1 + 2x_2', 'x_1 + 3x_2 = 6', '5x_1 + x_2 = 4', 'optimal point');

% Show the grid
grid on;
hold off;

