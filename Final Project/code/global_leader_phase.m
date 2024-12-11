%% Global Leader Phase
function monkey_positions = global_leader_phase(monkey_positions, global_leader, p_b, lb, ub)
    % Updates the positions of monkeys based on the global leader.
    
    [N, D] = size(monkey_positions);
    Cnt = 0;
    
    while Cnt < N
        for i = 1:N
            if rand() > p_b
                Cnt = Cnt + 1;
                j = randi(D);
                r_idx = randi(N);
                Krj = monkey_positions(r_idx, j);
                Kij = monkey_positions(i, j);
                Gloj = global_leader.position(j);
                
                % Position Update Equation
                K_new = Kij + rand() * (Gloj - Kij) + (rand() * 2 - 1) * (Krj - Kij);
                
                % Boundary Check
                K_new = min(max(K_new, lb(j)), ub(j));
                
                % Update Position
                monkey_positions(i, j) = K_new;
                
                if Cnt >= N
                    break;
                end
            end
        end
    end
end