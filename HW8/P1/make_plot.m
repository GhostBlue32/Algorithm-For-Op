function make_plot(f)
  % Creates plot used in lecture slides.
    
  xv = linspace(-5,5,100);
  yv = linspace(-5,5,100);
  [xm,ym] = meshgrid(xv,yv);
  zm = zeros(size(xm));
  for i=1:100; for j=1:100; zm(i,j) = f([xm(i,j);ym(i,j)]); end; end;
   
  % Plot red background rectangle
  fill([-5, 5, 5, -5], [-5, -5, 5, 5], [1, 0.8, 0.8]);
  hold on
  contour(xm,ym,zm, 10)
  % Set axis limits
  axis([-5 5 -5 5]);

  % Plot the constraint rectangle
  rectangle('Position', [-1 -2 2 4], 'EdgeColor', 'k', 'LineWidth', 1.5);
  fill([-1, 1, 1, -1], [-2, -2, 2, 2], 'w', 'FaceAlpha', 0.7);    
      
  % Add title and labels
  title('Projected gradient descent -- fobj1');
  xlabel('x');
  ylabel('y');

  
end
