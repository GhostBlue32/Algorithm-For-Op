%% Evaluate Fitness
function [fitness, objective_values] = evaluate_fitness(monkey_positions, obj_func)
    % Evaluates the fitness of each monkey based on the objective function.
    global FEVAL_COUNT;
    N = size(monkey_positions, 1);
    fitness = zeros(N, 1);
    objective_values = zeros(N, 1);
    
    for i = 1:N
        o_i = obj_func(monkey_positions(i, :));
        % Fitness calculation
        if o_i >= 0
            f_i = 1 / (1 + o_i);
        else
            f_i = 1 + abs(o_i);
        end
        fitness(i) = f_i;
        objective_values(i) = o_i;
    end
    FEVAL_COUNT = FEVAL_COUNT + N;  % Increment function evaluations
end