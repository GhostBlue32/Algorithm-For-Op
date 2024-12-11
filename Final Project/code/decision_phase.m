%% Decision Phase (Local Leader Decision)
function [monkey_positions, LLCnt] = decision_phase(monkey_positions, fitness, local_leaders, global_leader, LLCnt, LLL, p_b, lb, ub, groups, num_groups)
    % If Local Leader Limit is exceeded, perform position updates to encourage exploration.
    if LLCnt > LLL
        LLCnt = 0;
        % Perform repositioning for each group
        for g = 1:num_groups
            group_idx = groups{g};
            for i = group_idx
                for j = 1:length(monkey_positions(i, :))
                    % Find min and max in this group for dimension j
                    Kmnj = min(monkey_positions(group_idx, j));
                    Kmxj = max(monkey_positions(group_idx, j));
                    
                    if rand() >= p_b
                        % Update position to a random value within group bounds
                        K_new = Kmnj + rand() * (Kmxj - Kmnj);
                    else
                        % Update position influenced by global leader and a random group member
                        Kij = monkey_positions(i, j);
                        Gloj = global_leader.position(j);
                        Locij = local_leaders(g).position(j);
                        % Select a random monkey from the same group
                        r_idx = group_idx(randi(length(group_idx)));
                        Irj = monkey_positions(r_idx, j);
                        
                        % Position Update Equation
                        K_new = Kmnj + rand() * (Gloj - Kij) + rand() * (Irj - Locij);
                    end
                    
                    % Boundary Check
                    K_new = min(max(K_new, lb(j)), ub(j));
                    
                    % Update Position
                    monkey_positions(i, j) = K_new;
                end
            end
        end
    else
        LLCnt = LLCnt + 1;
    end
end