%% Local Leader Phase
function monkey_positions = local_leader_phase(monkey_positions, local_leaders, per_r, lb, ub, groups, num_groups)
    % Updates the positions of monkeys based on their local leaders.
    
    for g = 1:num_groups
        group_idx = groups{g};
        group_leader_pos = local_leaders(g).position;
        for i = group_idx
            for j = 1:length(group_leader_pos)
                if rand() >= per_r
                    Kij = monkey_positions(i, j);
                    Locj = group_leader_pos(j);
                    % Select a random monkey from the same group
                    r_idx = group_idx(randi(length(group_idx)));
                    Kkj = monkey_positions(r_idx, j);
                    
                    % Position Update Equation
                    K_new = Kij + rand() * (Locj - Kij) + (rand() * 2 - 1) * (Kkj - Kij);
                    
                    % Boundary Check
                    K_new = min(max(K_new, lb(j)), ub(j));
                    
                    % Update Position
                    monkey_positions(i, j) = K_new;
                end
            end
        end
    end
end