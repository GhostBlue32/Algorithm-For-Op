function plotting()
    
    % Generate the mesh grid for the domain
    N = 500; % Number of points for fine computation
    x = linspace(0, 4, N);
    y = linspace(0, 4, N);
    [X, Y] = meshgrid(x, y);
    
    % Compute function values
    Z = zeros(size(X));
    for i = 1:N
        for j = 1:N
            Z(i, j) = obj([X(i, j), Y(i, j)]);
        end
    end
    
    % Down-sample the grid for improved grid alignment and smoothness
    step = 10; % Adjust this for grid density
    X_sparse = X(1:step:end, 1:step:end);
    Y_sparse = Y(1:step:end, 1:step:end);
    Z_sparse = Z(1:step:end, 1:step:end);
    
    % Adjust the colormap to better match the provided image
    aligned_colormap = jet; % Start with 'jet' as the base colormap
    
    % 3D Surface Plot with neater gridlines
    figure(1);
    surf(X_sparse, Y_sparse, Z_sparse);
    title('Michalewicz Fcn');
    xlabel('x');
    ylabel('y');
    zlabel('f(x, y)');
    colormap(aligned_colormap); % Use aligned colormap
    shading faceted; % Keep gridlines visible on the surface
    grid on;
    view(3); % 3D view

    % Contour Plot with consistent colormap
    figure(2);
    contour(X, Y, Z, 50, 'LineWidth', 0.5); % 50 contour levels
    colormap(aligned_colormap); % Use the same colormap for consistency
    title('Michalewicz Fcn');
    xlabel('x');
    ylabel('y');
end