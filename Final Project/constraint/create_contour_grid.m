%% Create Contour Grid
function [x_grid, y_grid, z_grid] = create_contour_grid(obj_func, lb, ub)
    % Creates a grid for contour plotting of the objective function.
    
    grid_points = 100;  % Number of grid points per dimension
    [x_grid, y_grid] = meshgrid(linspace(lb(1), ub(1), grid_points), linspace(lb(2), ub(2), grid_points));
    z_grid = zeros(size(x_grid));
    for i = 1:size(x_grid,1)
        for j = 1:size(x_grid,2)
            z_grid(i,j) = obj_func([x_grid(i,j), y_grid(i,j)]);
        end
    end
end