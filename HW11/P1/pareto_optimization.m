function pareto_optimization()
    % Define A1 and A2 matrices
    A1 = [2.1213, 0.7071; -2.1213, 0.7071];
    A2 = [3.5640, -0.4540; 1.8160, 0.8910];
    
    % Define the lambda range
    lambda_values = linspace(0, 1, 100); % 100 points between 0 and 1
    
    % Store the Pareto optimal points
    pareto_points = zeros(length(lambda_values), 2);
    
    % Solve for each lambda
    for i = 1:length(lambda_values)
        lambda = lambda_values(i);
        % Define the combined gradient system
        gradient_system = @(vars) combined_gradient(vars, lambda, A1, A2);
        
        % Initial guess
        x0 = [0; 0];
        
        % Solve using fsolve
        options = optimoptions('fsolve', 'Display', 'none');
        pareto_points(i, :) = fsolve(gradient_system, x0, options);
    end
    
    % Plot the Pareto optimal points
    figure;
    scatter(pareto_points(:, 1), pareto_points(:, 2), 50, 'r', 'filled');
    title('Pareto Optimal Points in Design Space');
    xlabel('x');
    ylabel('y');
    grid on;
end

% Gradient system for the combined function
function grad = combined_gradient(vars, lambda, A1, A2)
    x = vars(1);
    y = vars(2);
    % Gradient of f1
    grad_f1 = 2 * A1 * [x - 2; y + 2];
    % Gradient of f2
    grad_f2 = 2 * A2 * [x + 2.5; y - 2.5];
    % Combined gradient
    grad = (1 - lambda) * grad_f1 + lambda * grad_f2;
end