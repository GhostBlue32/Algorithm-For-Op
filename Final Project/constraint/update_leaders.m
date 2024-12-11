%% Update Leaders
function [local_leaders, global_leader] = update_leaders(monkey_positions, fitness, groups, num_groups)
    % Updates the local leaders for each group and the global leader based on current fitness.
    
    % Initialize local leaders
    local_leaders = struct('position', {}, 'fitness', {});
    for g = 1:num_groups
        group_idx = groups{g};
        [best_fitness_group, best_index_group] = max(fitness(group_idx));
        local_leaders(g).position = monkey_positions(group_idx(best_index_group), :);
        local_leaders(g).fitness = best_fitness_group;
    end
    
    % Update global leader (highest fitness across all groups)
    [best_fitness, best_index] = max(fitness);
    global_leader.position = monkey_positions(best_index, :);
    global_leader.fitness = best_fitness;
end