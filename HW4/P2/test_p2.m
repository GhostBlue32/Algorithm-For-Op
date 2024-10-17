function test_p2()

    % number of data in a dataset
    N = 100;
    % beta
    beta = randn(1, 2);
    noise_amplitude = logspace(log10(1e-5), log10(3e-1), 10);
    normdiff = noise_amplitude;

    % vary different noise
    for i = 1:1:10
        amp = noise_amplitude(i);
        % Create the dataset
        x = linspace(-1.5, 1.5, 100);
        x = x';
        y = f(x, beta) + amp * (randn(N, 1) - 0.5);
        % Compute the diff
        H = H_matrix(x, y, beta);
        B = B_matrix(x, y, beta);
        normdiff(i) = norm(H - B);
    end
    % Create the plot
    % 绘制 log-log 图
    normdiff
    figure;
    loglog(noise_amplitude, normdiff, 'ro', 'MarkerFaceColor', 'r');
    xlabel('noise amplitude');
    ylabel('normdiff');
    title('normdiff vs. noise amplitude');
    

end