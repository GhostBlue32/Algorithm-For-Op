function plot_feasible_region(obj_func_type, lb, ub)
    % Plot feasible region based on the objective function type
    switch lower(obj_func_type)
        case 'rastrigin'
            % Constraint: x + y >= 1 and x = y
            % Feasible region lies on the line x = y where x >= 0.5
            
            % Plot the line x = y for x >=0.5
            fplot(@(x) x, [0.5, ub(1)], 'm-', 'LineWidth', 2);  % Solid magenta line for x = y, x >=0.5
            
            % Plot the boundary line x + y =1
            fplot(@(x) 1 - x, [lb(1), ub(1)], 'k--', 'LineWidth', 1.5);  % Dashed black line for x + y =1
            
            % Optional: Highlight the feasible region along the line x = y, x >=0.5
            % Since it's a line, shading isn't straightforward. Instead, use a thicker line or markers.
            % Here, we'll mark the feasible line with red color.
            fplot(@(x) x, [0.5, ub(1)], 'r-', 'LineWidth', 2);  % Solid red line for feasible solutions

        case 'himmelblau'
            % Constraints: x^2 + y^2 <=25 and y >=0
            % Feasible region is the upper half-circle centered at the origin with radius 5
            
            % Plot the circle x^2 + y^2 =25
            th = linspace(0, 2*pi, 100);
            x_circle = 5 * cos(th);
            y_circle = 5 * sin(th);
            plot(x_circle, y_circle, 'k--', 'LineWidth', 1.5);  % Dashed black line for x^2 + y^2 =25
            
            % Shade the feasible region (y >=0)
            fill([x_circle, fliplr(x_circle)], [y_circle, zeros(1,length(y_circle))], 'r', ...
                'FaceAlpha', 0.3, 'EdgeColor', 'none');  % Semi-transparent red
            
        case 'michalewicz'
            % Constraints: x + 2y <=3 and x - y >=-1
            % Feasible region is a polygon defined by these inequalities
            
            % Define a grid to find the feasible polygon vertices
            % For simplicity, manually calculate intersection points
            % Intersection of x +2y =3 and x - y =-1
            % Solve:
            % x + 2y =3
            % x - y =-1 => x = y -1
            % Substitute: (y -1) +2y =3 => 3y -1 =3 => y= 4/3, x=4/3 -1=1/3
            
            % Define the vertices of the feasible region
            vertices_x = [lb(1), 1/3, ub(1), ub(1), lb(1)];
            vertices_y = [lb(2), 4/3, 0, ub(2), ub(2)];
            
            % Plot the lines x +2y =3 and x - y =-1
            fplot(@(x) (3 - x)/2, [lb(1), ub(1)], 'k--', 'LineWidth', 1.5);  % Dashed black line for x +2y =3
            fplot(@(x) x +1, [lb(1), ub(1)], 'c--', 'LineWidth', 1.5);          % Dashed cyan line for x - y =-1
            
            % Shade the feasible region
            fill([1/3, ub(1), ub(1), 1/3], [4/3, 0, ub(2), ub(2)], 'r', ...
                'FaceAlpha', 0.3, 'EdgeColor', 'none');  % Semi-transparent red
            
        case 'schwefel'
            % Constraints: x >=100 and y >=100
            % Feasible region is the square [100, ub(1)] x [100, ub(2)]
            
            % Plot the boundaries
            rectangle('Position',[100, 100, ub(1)-100, ub(2)-100], ...
                'EdgeColor','k','LineStyle','--', 'LineWidth', 1.5);
            hold on;
            
            % Shade the feasible region
            fill([100, ub(1), ub(1), 100], [100, 100, ub(2), ub(2)], 'r', ...
                'FaceAlpha', 0.3, 'EdgeColor', 'none');  % Semi-transparent red
            
        case 'easom'
            % Constraints: x^2 + y^2 <=50 and x >=0
            % Feasible region is the intersection of the circle x^2 + y^2 <=50 and x >=0
            
            % Plot the circle x^2 + y^2 =50
            th = linspace(0, 2*pi, 100);
            x_circle = sqrt(50) * cos(th);
            y_circle = sqrt(50) * sin(th);
            plot(x_circle, y_circle, 'k--', 'LineWidth', 1.5);  % Dashed black line for x^2 + y^2 =50
            
            % Shade the feasible region (x >=0 and x^2 + y^2 <=50)
            fill([0, x_circle, sqrt(50)], [0, y_circle, 0], 'r', ...
                'FaceAlpha', 0.3, 'EdgeColor', 'none');  % Semi-transparent red
                
        otherwise
            % No feasible region to plot
    end
end