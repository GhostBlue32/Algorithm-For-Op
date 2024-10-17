function test_P3()
    tic;
    for N = 5:1:12
        start_time = toc;
        % Make city table and cities
        P = make_cities(N);
        T = make_distance_table(P);
        fprintf('N = %d\n', N);
        [Vs, ds] = run_simulated_annealing(N, P, T);
        mid_time = toc;
        an_time = mid_time - start_time;
        [tV, td] = run_brute(N, T, Vs, ds);
        fprintf('True travel distance = %f\n', td);
        fprintf('True minimum travel order');
        disp(tV)
        end_time = toc;
        secondSegmentTime = end_time - start_time;
        fprintf('N = %d annealing use %.4f second\n', N, an_time);
        fprintf('N = %d brute method use %.2f second\n', N, secondSegmentTime);
        if ds == td
            fprintf('The annealing answer is the truth\n')
        else
            fprintf('The annealing answer is fail.\n')
        end
    end
end