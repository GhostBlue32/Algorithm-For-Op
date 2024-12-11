N = 500;
xv = linspace(-4,4,N);
yv = linspace(-4,4,N);

[Xm, Ym] = meshgrid(xv,yv);

Zm = zeros(N,N);
for i=1:N; 
for j=1:N
  Zm(i,j) = f([Xm(i,j),Ym(i,j)]);
end; 
end
figure(1)
% Adjust top of range to move contours to show optimal pt
% is where the objective fcn's levelsets and the 
% constraint line are tangent.
lvls = logspace(.001,7.31,51);
contour(Xm,Ym,Zm,lvls);
hold on
xlabel('x_1');
ylabel('x_2');
axis([-4, 4, -4, 4]);
title('Perm function with quadratic equality constraint');
hold on;

% Plot the constraint x2 = x1^2 - 1
x1_constraint = linspace(-4, 4, 400);
x2_constraint = x1_constraint.^2 - 1;
plot(x1_constraint, x2_constraint, 'k', 'LineWidth', 2);

% Set up the optimization problem
% Initial guess
x0 = [0; 0];

% Define the nonlinear constraint
nonlcon = @(x) constraint_function(x);

% Use fmincon to minimize the function under the constraint
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');

% Call fmincon to minimize the function under the constraint
[x_opt, fval, exitflag, output] = fmincon(@f, x0, [], [], [], [], [], [], @nonlcon, options);

% Display the optimization results
fprintf('Optimal solution:\n');
fprintf('x_1 = %.6f\n', x_opt(1));
fprintf('x_2 = %.6f\n', x_opt(2));
fprintf('Minimum function value: f(x) = %.6f\n', fval);

% Plot the optimal point on the contour plot
plot(x_opt(1), x_opt(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
text(x_opt(1), x_opt(2), sprintf('  Minimum at (%.2f, %.2f)', x_opt(1), x_opt(2)), 'Color', 'w');
legend('f(x)', 'Constraint x_2 = x_1^2 - 1', 'Optimal point');

hold off;
