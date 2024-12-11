function test_P1()
  
  % First make contour plot of obj fcn
    
  N = 500;
  xv = linspace(-4,4,N);
  yv = linspace(-4,4,N);
  
  [Xm, Ym] = meshgrid(xv,yv);
  
  Zm = zeros(N,N);
  for i=1:N; 
    for j=1:N
      Zm(i,j) = f([Xm(i,j),Ym(i,j)]);
    end; 
  end
  figure(1)
  % Adjust top of range to move contours to show optimal pt
  % is where the objective fcn's levelsets and the 
  % constraint line are tangent.
  lvls = logspace(.001,7.31,51);
  contour(Xm,Ym,Zm,lvls);
  hold on

  % Now make plot of equality constraint
  x1 = linspace(-4,4,100);
  x2 = x1.^2 - 1;
  plot(x1,x2,'k-', 'LineWidth', 2)

  % Initial guess -- this affects the final min pt found.
  X0 = [1;3;1];
  
  ustar = newton_eq(@f, @mygrad, @myhess, @myC, @myd, X0)

  xstar = ustar(1:2);

  plot(xstar(1),xstar(2),'ro', 'MarkerSize',7,'MarkerFaceColor','r')
  fprintf('Optimal solution:\n');
  fprintf('x_1 = %.6f\n', xstar(1));
  fprintf('x_2 = %.6f\n', xstar(2));
  fprintf('Minimum function value: f(x) = %.6f\n', f(xstar));
  title('Perm function with quadratic equality constraint')
  axis([-4, 4, -4, 4]);
  xlabel('x1')
  ylabel('x2')
  legend('f(x)', 'Constraint x_2 = x_1^2 - 1', 'Optimal point');
  
  
end

    