%% Population Initialization
function monkey_positions = initialize_population(N, D, lb, ub)
    % Initializes the positions of N monkeys in D dimensions within the bounds.
    monkey_positions = zeros(N, D);
    for d = 1:D
        monkey_positions(:, d) = lb(d) + (ub(d) - lb(d)) * rand(N, 1);
    end
end