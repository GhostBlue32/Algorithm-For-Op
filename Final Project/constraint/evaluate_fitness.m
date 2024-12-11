%% Evaluate Fitness
function [fitness, objective_values] = evaluate_fitness(monkey_positions, obj_func, constraints, penalty_coefficients)
    % Evaluates the fitness of each monkey based on the objective function and constraints.
    global FEVAL_COUNT;
    N = size(monkey_positions, 1);
    fitness = zeros(N, 1);
    objective_values = zeros(N, 1);
    
    for i = 1:N
        x = monkey_positions(i, 1);
        y = monkey_positions(i, 2);
        
        % Objective Function Evaluation
        o_i = obj_func([x, y]);
        objective_values(i) = o_i;
        
        % Constraints Evaluation
        penalty = 0;
        for c = 1:length(constraints)
            g = constraints{c}(x, y);  % For inequality: g(x,y) <=0
            if g > 0
                penalty = penalty + penalty_coefficients.lambda * g^2;
            end
        end
        % Handle equality constraints (if any)
        % Assuming equality constraints are provided as h(x,y)=0
        % For this implementation, treat equality constraints as |h(x,y)| <= epsilon
        % If equality constraints are mixed in constraints list, distinguish them
        % Here, it's assumed that equality constraints are handled separately
        % For simplicity, in this code, all constraints are treated as inequality constraints
        % If you have separate equality constraints, add them here with penalty_coefficients.mu
        
        % Penalized Objective
        o_p = o_i + penalty;
        
        % Fitness Calculation (Inverse of Penalized Objective)
        % Since we are minimizing, higher fitness corresponds to lower o_p
        if o_p >= 0
            f_i = 1 / (1 + o_p);
        else
            f_i = 1 + abs(o_p);
        end
        fitness(i) = f_i;
    end
    FEVAL_COUNT = FEVAL_COUNT + N;  % Increment function evaluations
end