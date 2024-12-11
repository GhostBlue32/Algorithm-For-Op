function [best_position, best_fitness] = SMO_2D_Optimization(obj_fun)
    % Revised Spider Monkey Optimization (SMO) Algorithm with Constraints
    % Inputs:
    %   obj_func_type - String indicating the type of objective function
    %                   e.g., 'rastrigin', 'himmelblau', 'michalewicz',
    %                         'schwefel', 'easom'
    %
    % Outputs:
    %   best_position - Coordinates (x, y) of the best solution found
    %   best_fitness  - Fitness value of the best solution
    
    %% Parameters
    N = 30;                % Population size
    D = 2;                 % Number of dimensions (2D plane)
    per_r = 0.3;           % Perturbation rate
    p_b = 0.4;             % Probability bound
    LLL = 1500;            % Local Leader Limit
    GLL = 50;              % Global Leader Limit
    max_group = 5;         % Maximum number of groups
    max_func_evals = 2e4;  % Maximum number of function evaluations
    
    %% Define Objective Function and Constraints
    switch lower(obj_fun)
        case 'rastrigin'
            obj_func = @rastrigin_function;
            constraints = {
                @(x, y) -(x + y - 1);    % x + y >= 1 => -(x + y -1) <= 0
                @(x, y) x - y             % x - y = 0 => |x - y| must be minimized
            };
            penalty_coefficients = struct('lambda', 1000, 'mu', 1000);
            lower_bound = [-5.12, -5.12];
            upper_bound = [5.12, 5.12];
        case 'himmelblau'
            obj_func = @himmelblau_function;
            constraints = {
                @(x, y) 25 - (x^2 + y^2);  % x^2 + y^2 <= 25
                @(x, y) -y                % y >= 0 => -y <= 0
            };
            penalty_coefficients = struct('lambda', 1000, 'mu', 1000);
            lower_bound = [-5, -5];
            upper_bound = [5, 5];
        case 'michalewicz'
            obj_func = @michalewicz_function;
            constraints = {
                @(x, y) 3 - (x + 2*y);    % x + 2y <= 3 => 3 - (x +2y) >=0
                @(x, y) x - y + 1         % x - y >= -1 => x - y +1 >=0
            };
            penalty_coefficients = struct('lambda', 1000, 'mu', 1000);
            lower_bound = [0, 0];
            upper_bound = [pi, pi];
        case 'schwefel'
            obj_func = @schwefel_function;
            constraints = {
                @(x, y) -x + 100;  % x >= 100 => -x + 100 <=0
                @(x, y) -y + 100   % y >= 100 => -y + 100 <=0
            };
            penalty_coefficients = struct('lambda', 1000, 'mu', 1000);
            lower_bound = [100, 100];
            upper_bound = [500, 500];
        case 'easom'
            obj_func = @easom_function;
            constraints = {
                @(x, y) 50 - (x^2 + y^2);  % x^2 + y^2 <= 50
                @(x, y) -x                   % x >= 0 => -x <=0
            };
            penalty_coefficients = struct('lambda', 1000, 'mu', 1000);
            lower_bound = [-100, -100];
            upper_bound = [100, 100];
        otherwise
            error('Unsupported objective function type.');
    end
    
    %% Initialize Population
    monkey_positions = initialize_population(N, D, lower_bound, upper_bound);
    
    %% Initialize Function Evaluation Count
    global FEVAL_COUNT;
    FEVAL_COUNT = 0;
    
    %% Evaluate Initial Fitness with Constraints
    [fitness, objective_values] = evaluate_fitness(monkey_positions, obj_func, constraints, penalty_coefficients);
    
    %% Initialize Groups (Start with one group)
    groups = {1:N};            % Cell array where each cell contains indices of monkeys in a group
    num_groups = 1;            % Current number of groups
    
    %% Initialize Leaders (Global and Local)
    [local_leaders, global_leader] = initialize_leaders(monkey_positions, fitness, groups, num_groups);
    
    %% Initialize Counters
    LLCnt = 0;    % Local Leader counter
    GLCnt = 0;    % Global Leader counter
    
    %% Initialize Plot (Contour and initial monkey positions)
    figure;
    hold on;
    [x_grid, y_grid, z_grid] = create_contour_grid(obj_func, lower_bound, upper_bound);
    contour(x_grid, y_grid, z_grid, 50, 'LineColor', [0.8 0.8 0.8]);  % Light grey contour lines
    
    % Plot feasible region boundaries (optional)
    plot_feasible_region(obj_fun, lower_bound, upper_bound);
    
    % Initialize scatter plot handles for monkeys and global leader
    h_monkeys = scatter(monkey_positions(:, 1), monkey_positions(:, 2), 36, 'blue', 'filled');
    h_global_leader = scatter(global_leader.position(1), global_leader.position(2), 100, 'red', 'filled', 'MarkerEdgeColor', 'k');
    legend('Objective Function Contours', 'Monkeys', 'Global Leader');
    text_pos = [lower_bound(1) + 0.1*(upper_bound(1)-lower_bound(1)), ...
                upper_bound(2) - 0.05*(upper_bound(2)-lower_bound(2))];
    h_text = text(text_pos(1), text_pos(2), ['FEVAL: ', num2str(FEVAL_COUNT)], 'FontSize', 12);
    drawnow;
    
    %% Main Optimization Loop
    while FEVAL_COUNT < max_func_evals
        %% Step 2: Local Leader Phase
        monkey_positions = local_leader_phase(monkey_positions, local_leaders, per_r, lower_bound, upper_bound, groups, num_groups);
        
        %% Evaluate Fitness After Local Leader Phase
        [fitness, objective_values] = evaluate_fitness(monkey_positions, obj_func, constraints, penalty_coefficients);
        
        %% Step 3: Global Leader Phase
        monkey_positions = global_leader_phase(monkey_positions, global_leader, p_b, lower_bound, upper_bound);
        
        %% Evaluate Fitness After Global Leader Phase
        [fitness, objective_values] = evaluate_fitness(monkey_positions, obj_func, constraints, penalty_coefficients);
        
        %% Step 5: Decision Phase (Local Leader Decision)
        [monkey_positions, LLCnt] = decision_phase(monkey_positions, fitness, local_leaders, global_leader, LLCnt, LLL, p_b, lower_bound, upper_bound, groups, num_groups, constraints, penalty_coefficients);
        
        %% Evaluate Fitness After Decision Phase
        [fitness, objective_values] = evaluate_fitness(monkey_positions, obj_func, constraints, penalty_coefficients);
        
        %% Update Leaders After Decision Phase
        [local_leaders, global_leader] = update_leaders(monkey_positions, fitness, groups, num_groups);
        
        %% Step 6: Fusion-Fission Decision (Global Leader Decision)
        [groups, local_leaders, global_leader, GLCnt, num_groups] = fusion_fission(monkey_positions, fitness, local_leaders, global_leader, GLCnt, GLL, max_group, groups, num_groups);
        
        %% Evaluate Fitness After Fusion-Fission
        [fitness, objective_values] = evaluate_fitness(monkey_positions, obj_func, constraints, penalty_coefficients);
        
        %% Update Leaders After Fusion-Fission
        [local_leaders, global_leader] = update_leaders(monkey_positions, fitness, groups, num_groups);
        
        %% Visualization: Update Monkey Positions and Global Leader
        set(h_monkeys, 'XData', monkey_positions(:, 1), 'YData', monkey_positions(:, 2));
        set(h_global_leader, 'XData', global_leader.position(1), 'YData', global_leader.position(2));
        set(h_text, 'String', ['FEVAL: ', num2str(FEVAL_COUNT)]);
        drawnow;
    end
    
    hold off;
    
    %% Final Best Solution
    [best_fitness, best_index] = max(fitness);   % Largest fitness is best
    best_position = monkey_positions(best_index, :);
    
    %% Output Results
    disp('Optimization Completed.');
    disp(['Best Position: x = ', num2str(best_position(1)), ', y = ', num2str(best_position(2))]);
    disp(['Best Fitness: ', num2str(best_fitness)]);
    disp(['Function Evaluations: ', num2str(FEVAL_COUNT)]);
end


%% Himmelblau's Function with Constraints
function o_i = himmelblau_function(position)
    % f(x, y) = (x^2 + y - 11)^2 + (x + y^2 - 7)^2
    x = position(1);
    y = position(2);
    o_i = (x^2 + y - 11)^2 + (x + y^2 - 7)^2;
end

%% Michalewicz Function with Constraints
function o_i = michalewicz_function(position)
    % f(x, y) = -sin(x)*(sin(x^2/pi))^10 - sin(y)*(sin(2*y^2/pi))^10
    x = position(1);
    y = position(2);
    m = 10;  % Parameter 'm' controls the steepness of valleys
    o_i = -sin(x) * (sin(x^2 / pi))^m - sin(y) * (sin(2*y^2 / pi))^m;
end

%% Schwefel Function with Constraints
function o_i = schwefel_function(position)
    % f(x, y) = 2*418.9829 - (x*sin(sqrt(|x|)) + y*sin(sqrt(|y|)))
    x = position(1);
    y = position(2);
    o_i = 2 * 418.9829 - (x * sin(sqrt(abs(x))) + y * sin(sqrt(abs(y))));
end
%% Easom Function with Constraints
function o_i = easom_function(position)
    % f(x, y) = -cos(x)*cos(y)*exp(-((x - pi)^2 + (y - pi)^2))
    x = position(1);
    y = position(2);
    o_i = -cos(x) * cos(y) * exp(-((x - pi)^2 + (y - pi)^2));
end