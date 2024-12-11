function xstar = test_P3()
  % This tests the genetic optimization algo on an
  % objective fcn with two minima, one deeper than the other.
  
  % Obj fcn
  m = 10;
  f = @(x,y) -sin(x) .* (sin(x.^2/pi)).^(2 * m) - sin(y) * (sin(2 * y.^2/pi)).^(2 * m) + 2;
  

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

  % Create initial population.  We work on [0,1]x[0,1] space.
  N1 = 25;  % Total number of individuals in this population
  x = rand(N1,1) * 4;
  y = rand(N1,1) * 4;  
  P = [x,y];
  
  % Contour Plot with consistent colormap
  figure(1);
  contour(X, Y, Z, 50, 'LineWidth', 0.5);
  title('Michalewicz Fcn');
  xlabel('x');
  ylabel('y');
  hold on
  
  % Plot intial population
  plt = plot(P(:,1),P(:,2),'ro');
  fprintf('Hit any key to continue ... \n')
  pause()
  
  nGens = 1;
  % Loop and make plot after every nGens 
  for i = 1:30
    Pstar = genetic_algo(f, P, nGens);
    delete(plt)
    plt = plot(Pstar(:,1),Pstar(:,2),'ro');
    %pause(0.2)
    P = Pstar;
  end

  xstar = mean(P);
  %disp(size(P,1));
  fprintf('At end of run, estimated xstar = [%f, %f]\n', xstar(1), xstar(2))
  fprintf('Obj fcn value = %e\n', f(xstar(1), xstar(2)));
  fprintf('Original obj fcn value = %e\n', -2 + f(xstar(1), xstar(2)));
  hold off
  

  % Down-sample the grid for improved grid alignment and smoothness
  step = 10; % Adjust this for grid density
  X_sparse = X(1:step:end, 1:step:end);
  Y_sparse = Y(1:step:end, 1:step:end);
  Z_sparse = Z(1:step:end, 1:step:end);
    
  % Adjust the colormap to better match the provided image
  aligned_colormap = jet; % Start with 'jet' as the base colormap
    
  % 3D Surface Plot with neater gridlines
  figure(2);
  surf(X_sparse, Y_sparse, Z_sparse);
  hold on
  plot3(xstar(1), xstar(2), f(xstar(1), xstar(2)), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
  title('Michalewicz Fcn');
  xlabel('x');
  ylabel('y');
  zlabel('f(x, y)');
  colormap(aligned_colormap); % Use aligned colormap
  shading faceted; % Keep gridlines visible on the surface
  grid on;
  view(3); % 3D view
  hold off
end
