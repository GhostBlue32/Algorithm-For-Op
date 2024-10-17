function test_newton_f1()

  

  global lim
  lim = 5;
  
  %startpt = [30; 50];
  X = [2; 2];
  startpt = X;
  plot(X(1), X(2), 'ro','MarkerFaceColor','r','MarkerSize',5)
  % fprintf('X = [ %f; %f ]\n', startpt(1), startpt(2))
  hold on

  N = 250;
  figure(1)
  x = linspace(lim, -lim, N);
  y = linspace(lim, -lim, N);
  [xm, ym] = meshgrid(x, y);
  for r = 1:N; for c = 1:N
    % Do plot of log(1+fcn) since its contours are much more clear
    zm(r, c) = log( 1+f1([xm(r,c), ym(r,c)]) );
  end; end;
  contour(xm, ym, zm, 10);
  
  xstar = newton_optimizer(@f1, @grad_1, @hess_1, startpt, 1e-4);
  plot(xstar(1), xstar(2), 'bo','MarkerFaceColor','b','MarkerSize',5)
  legend('The curve', 'Starting point', 'End point');
  fprintf('Found minimum xstar = [ %f; %f ]\n', xstar(1), xstar(2))
  hold off
end
