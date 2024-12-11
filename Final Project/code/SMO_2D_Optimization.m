function [best_position, best_fitness] = SMO_2D_Optimization()
    % Revised Spider Monkey Optimization (SMO) Algorithm
    % Incorporates:
    % 1) Largest fitness selection for leaders.
    % 2) Dynamic grouping with split and merge based on Global Leader Limit (GLL).
    % 3) Updated parameters: GLL=50, LLL=1500, max function evaluations=200,000.
    % 4) Contour plot of the objective function with real-time visualization.

    %% Parameters
    N = 50;                % Population size
    D = 2;                 % Number of dimensions (2D plane)
    per_r = 0.1;           % Perturbation rate
    p_b = 0.4;             % Probability bound
    LLL = 1500;            % Local Leader Limit
    GLL = 50;              % Global Leader Limit
    max_group = 5;         % Maximum number of groups
    max_func_evals = 3e4;  % Maximum number of function evaluations

    %% Search Space Boundaries
    lower_bound = [-5, -5];  % Lower bounds for x and y
    upper_bound = [5, 5];    % Upper bounds for x and y

    %% Initialize Population
    monkey_positions = initialize_population(N, D, lower_bound, upper_bound);

    %% Initialize Function Evaluation Count
    global FEVAL_COUNT;
    FEVAL_COUNT = 0;

    %% Evaluate Initial Fitness
    [fitness, objective_values] = evaluate_fitness(monkey_positions, @objective_function);

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
    x_min = lower_bound(1);
    x_max = upper_bound(1);
    y_min = lower_bound(2);
    y_max = upper_bound(2);
    axis([x_min, x_max, y_min, y_max]);
    xlabel('x');
    ylabel('y');
    title('Spider Monkey Optimization Progress');
    hold on;

    % Create grid for contour plot
    grid_points = 100;  % Number of grid points per dimension
    [x_grid, y_grid] = meshgrid(linspace(x_min, x_max, grid_points), linspace(y_min, y_max, grid_points));
    % Compute objective function on grid
    z_grid = arrayfun(@(x, y) objective_function([x, y]), x_grid, y_grid);
    % Plot contour
    contour(x_grid, y_grid, z_grid, 100, 'LineColor', [0.8 0.8 0.8]);  % Light grey contour lines
    hold on;

    % Initialize scatter plot handles for monkeys and global leader
    h_monkeys = scatter(monkey_positions(:, 1), monkey_positions(:, 2), 36, 'blue', 'filled');
    h_global_leader = scatter(global_leader.position(1), global_leader.position(2), 100, 'red', 'filled', 'MarkerEdgeColor', 'k');
    legend('Objective Function Contours', 'Monkeys', 'Global Leader');
    text(x_min + 0.1, y_max - 0.5, ['FEVAL: ', num2str(FEVAL_COUNT)], 'FontSize', 12);
    drawnow;
    pause;

    %% Main Optimization Loop
    while FEVAL_COUNT < max_func_evals
        per_r = per_r + (0.5-0.1)*max_func_evals;
        %% Step 2: Local Leader Phase
        monkey_positions = local_leader_phase(monkey_positions, local_leaders, per_r, lower_bound, upper_bound, groups, num_groups);

        %% Evaluate Fitness After Local Leader Phase
        [fitness, objective_values] = evaluate_fitness(monkey_positions, @objective_function);

        %% Step 3: Global Leader Phase
        monkey_positions = global_leader_phase(monkey_positions, global_leader, p_b, lower_bound, upper_bound);

        %% Evaluate Fitness After Global Leader Phase
        [fitness, objective_values] = evaluate_fitness(monkey_positions, @objective_function);

        %% Step 5: Decision Phase (Local Leader Decision)
        [monkey_positions, LLCnt] = decision_phase(monkey_positions, fitness, local_leaders, global_leader, LLCnt, LLL, p_b, lower_bound, upper_bound, groups, num_groups);

        %% Evaluate Fitness After Decision Phase
        [fitness, objective_values] = evaluate_fitness(monkey_positions, @objective_function);

        %% Update Leaders After Decision Phase
        [local_leaders, global_leader] = update_leaders(monkey_positions, fitness, groups, num_groups);

        %% Step 6: Fusion-Fission Decision (Global Leader Decision)
        [groups, local_leaders, global_leader, GLCnt, num_groups] = fusion_fission(monkey_positions, fitness, local_leaders, global_leader, GLCnt, GLL, max_group, groups, num_groups);

        %% Evaluate Fitness After Fusion-Fission
        [fitness, objective_values] = evaluate_fitness(monkey_positions, @objective_function);

        %% Update Leaders After Fusion-Fission
        [local_leaders, global_leader] = update_leaders(monkey_positions, fitness, groups, num_groups);

        %% Visualization: Update Monkey Positions and Global Leader
        set(h_monkeys, 'XData', monkey_positions(:, 1), 'YData', monkey_positions(:, 2));
        set(h_global_leader, 'XData', global_leader.position(1), 'YData', global_leader.position(2));
        % Update function evaluations text
        h_text = findobj(gca, 'Type', 'text');
        set(h_text, 'String', ['FEVAL: ', num2str(FEVAL_COUNT)]);
        drawnow;
        if FEVAL_COUNT == 1e4
            pause
        end

        %% Optionally, Display Iteration Progress
        % disp(['FEVAL: ', num2str(FEVAL_COUNT), ' Best Fitness: ', num2str(max(fitness))]);
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
    fprintf('The objective function value is %f\n', objective_function(best_position))
end