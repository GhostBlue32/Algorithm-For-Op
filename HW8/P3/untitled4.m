% Define the function f(x, y) = xy
f = @(x, y) x .* y;

% Define grid for plotting
x = linspace(-2, 2, 100);
y = linspace(-2, 2, 100);
[X, Y] = meshgrid(x, y);
Z = f(X, Y);

% Create the contour plot
figure;
% Set the background to red
fill([-2, 2, 2, -2], [-2, -2, 2, 2], [1, 0.8, 0.8]);
hold on;
contour(X, Y, Z, 20); % 20 contour levels


% Plot the circle x^2 + y^2 = 1
theta = linspace(0, 2*pi, 100);
xc = cos(theta);
yc = sin(theta);
fill(xc, yc, 'w', 'FaceAlpha', 0.5, 'EdgeColor', 'b'); % Translucent white circle

% Additional plot settings
axis equal;
xlabel('x');
ylabel('y');
title('Contour plot of f(x, y) = xy');
hold off;