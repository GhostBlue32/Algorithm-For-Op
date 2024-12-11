%% Split Groups
function groups = split_groups(monkey_positions, new_num_groups)
    % Splits the population into 'new_num_groups' groups randomly.
    
    N = size(monkey_positions, 1);
    indices = randperm(N);  % Shuffle indices for random grouping
    group_size = floor(N / new_num_groups);
    remainder = mod(N, new_num_groups);
    
    groups = cell(new_num_groups, 1);
    start_idx = 1;
    
    for g = 1:new_num_groups
        sz = group_size + (g <= remainder);  % Distribute the remainder
        end_idx = start_idx + sz - 1;
        groups{g} = indices(start_idx:end_idx);
        start_idx = end_idx + 1;
    end
end