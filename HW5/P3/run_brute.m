function [tV, td] = run_brute(N, T, Vs, ds)
    % Names of cities to visit.  I just name them a, b, c, ....
    % The below is a tricky way to create the city names using
    % Matlab string conversion stuff.
    for i=1:N
        C{i} = char(i+96); 
    end
    V = horzcat(C, C(1));
    V_start = C{1};
    cities_to_permute = C(2:end);
    td = ds;
    tV = Vs;
    % create permuatations
    all_permutations = perms(cities_to_permute);
    % Preallocate an array to store distances
    num_permutations = size(all_permutations, 1);
    % set progress
    bar_length = 50; 
    update_percentage = 1; 
    update_interval = ceil(num_permutations * (update_percentage / 100));
    if update_interval < 1
        update_interval = 1;
    end
    next_update = update_interval;
    progress_bar = sprintf('Progress: [%-50s]  0%%', '');
    fprintf('%s', progress_bar);
    previous_length = length(progress_bar);
    for i = 1:num_permutations
        V_perm = [V_start, all_permutations(i, :), V_start];
        d = compute_travel_distance(C, V_perm, T);
        if (d < td)
            td = d;
            tV = V_perm;
        end
        if i >= next_update || i == num_permutations
            percent = floor((i / num_permutations) * 100);
            completed_length = floor((percent / 100) * bar_length);
            progress_str = [repmat('#', 1, completed_length), repmat(' ', 1, bar_length - completed_length)];
            current_progress = sprintf('Progress: [%-50s] %3d%%', progress_str, percent);
            
            % 计算需要退格的数量
            num_backs = previous_length;
            fprintf(repmat('\b', 1, num_backs));
            
            % 打印新的进度条
            fprintf('%s', current_progress);
            
            % 更新之前进度条的长度
            previous_length = length(current_progress);
            
            % 更新下一个更新点
            next_update = next_update + update_interval;
        end
    end
    progress_str = [repmat('#', 1, bar_length), repmat(' ', 1, 0)];
    current_progress = sprintf('Progress: [%-50s] 100%%', progress_str);
    num_backs = previous_length;
    fprintf(repmat('\b', 1, num_backs));
    fprintf('%s\n', current_progress);    
end