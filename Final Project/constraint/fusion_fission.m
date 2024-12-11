%% Fusion-Fission Phase (Global Leader Decision)
function [groups, local_leaders, global_leader, GLCnt, num_groups] = fusion_fission(monkey_positions, fitness, local_leaders, global_leader, GLCnt, GLL, max_group, groups, num_groups)
    % Manages dynamic grouping based on Global Leader Limit (GLL).
    
    % Increment Global Leader counter
    GLCnt = GLCnt + 1;
    
    if GLCnt > GLL
        % Reset Global Leader counter
        GLCnt = 0;
        
        if num_groups < max_group
            % Split into n+1 groups
            new_num_groups = num_groups + 1;
            groups = split_groups(monkey_positions, new_num_groups);
            num_groups = new_num_groups;
        else
            % If already at max_group, merge back into one group
            if num_groups == max_group
                groups = {1:size(monkey_positions, 1)};  % Single group with all monkeys
                num_groups = 1;
            end
            % Else, do nothing
        end
    end
    
    % Update Leaders After Grouping Changes
    [local_leaders, global_leader] = update_leaders(monkey_positions, fitness, groups, num_groups);
end