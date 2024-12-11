%% Create Group Indices
function local_leaders_struct = create_group_indices(monkey_positions, num_groups)
    N = size(monkey_positions, 1);
    group_size = floor(N / num_groups);
    remainder = mod(N, num_groups);

    group_indices = cell(num_groups, 1);
    start_idx = 1;
    for g = 1:num_groups
        sz = group_size + (g <= remainder);
        group_indices{g} = start_idx:(start_idx+sz-1);
        start_idx = start_idx + sz;
    end

    local_leaders_struct.positions = monkey_positions;
    local_leaders_struct.group_indices = group_indices;
    local_leaders_struct.num_groups = num_groups;
    % fitness not set here, will be updated later
end