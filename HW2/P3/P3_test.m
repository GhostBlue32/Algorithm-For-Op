function P3_test()

    
     % Read the data
    data = readmatrix('wind_speed_boston_corrected.csv');

    % The MLE result
    u0 = [6, 8];
    tol = 1e-5;
    k_lambda = mygd(data, u0, tol)
    %k_lambda = mysgd_plain(data, u0, tol)

    % Plot histogram
    figure;
    hold on
    histogram(data, 'BinWidth', 1, 'FaceColor', 'cyan', 'EdgeColor', 'black');

    % Get the wblfit result
    % wblfit result lambda_k, first one lambda, second one k
    [lambda_k, ~] = wblfit(data);


    % rescale the pdf
    x_fit = linspace(0, max(data), 1000);
    pdf_values = f(x_fit, lambda_k(2), lambda_k(1));
    pdf_value_my = f(x_fit, k_lambda(1), k_lambda(2));
    [counts, edges] = histcounts(data, 'BinWidth', 1);
    bin_width = edges(2) - edges(1);  % width of bins
    hist_area = sum(counts) * bin_width;
    factor = hist_area;

    % Show the k and lambda value of wblfit
    x_position = (max(data) - min(data)) / 2 + min(data);  
    y_position = max(counts) / 2;
    line_height = 0.05 * (max(counts) - min(counts));  
    y_position_new = y_position - 2 * line_height;
    text(x_position, y_position, sprintf('k^* = %.4f\n\\lambda^* = %.4f', lambda_k(2), lambda_k(1)), 'FontSize', 12, 'Color', 'blue', 'FontWeight', 'bold');
    text(x_position, y_position_new, sprintf('k = %.4f\n\\lambda = %.4f', k_lambda(1), k_lambda(2)), 'FontSize', 12, 'Color', 'blue', 'FontWeight', 'bold');

    % Plot the rescaled pdf
    plot(x_fit, factor * pdf_values, 'r-', 'LineWidth', 2);
    plot(x_fit, factor * pdf_value_my, 'b-', 'LineWidth', 3);

    % Set the title label and legend

    title('Histogram of input data');
    xlabel('Wind speed (m/sec)');
    ylabel('Incidence(counts)');
    lgd = legend('Histogram of data', 'wblfit result (k^*, \lambda^*)', 'my result(k, \lambda)',  'Location', 'northeast'); 
    lgd.FontSize = 14;
    hold off
end