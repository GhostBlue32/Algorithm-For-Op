function test_P2()
  % This covers the design space with a grid and then
  % uses the "dominates" predicate to color the points
  % to trace out the Pareto optimal points in both 
  % design and objective space.

    
  % Create points in design space.
  N = 60;
  xv = linspace(-3,3,N);
  yv = linspace(-3,3,N);
  [Xm, Ym] = meshgrid(xv,yv);

  
  
  
  % Next objective space.
  figure(2)
  for i=1:N
    for j=1:N
      % Compute both obj fcns at point [i,j]
      f1ij = f1(Xm(i,j),Ym(i,j));
      f2ij = f2(Xm(i,j),Ym(i,j));      
      plot(f1ij,f2ij,'g.')
      hold on
    end
  end
  xlabel('f1')
  ylabel('f2')
  title('Objective space')
  xlim([-10,60])
  ylim([-5,35])


  % Now double loop over points in design space and 
  % find points x which correspond to non-dominating points.
  saveidx = [];
  % Do linear indexing here.
  for i1 = 1:N*N
    p1 = [Xm(i1),Ym(i1)];
    for i2 = 1:N*N
      p2 = [Xm(i2),Ym(i2)];
      if dominates(p2,p1,@f1,@f2)
	% p2 dominates p1.
	dom = true;
	break
      else
	% p1 not dominated
	dom = false;
      end
    end
    if (dom == false)
      % Point p1 is non-dominated.  Record it.
      saveidx = [saveidx, i1];
    end
  end
  
  %fprintf('saveidx = ')
  %disp(saveidx)
  
  for i = 1:length(saveidx)
    idx = saveidx(i);
    x = Xm(idx);
    y = Ym(idx);
    %fprintf('Plotting Pareto optimal point [%f, %f]\n', x, y)
    figure(2)
    plot(f1(x,y),f2(x,y),'ro','MarkerFaceColor','r','MarkerSize',5)
  end

  % This is a hack to create the legend.  Just replot the last
  % values with DisplayName to make the legend.
  plt1 = plot(f1(x,y),f2(x,y),'ro','MarkerFaceColor','r','MarkerSize',5, ...
       'DisplayName','gridmethod');
  
  % The weighted sum method
  M = 10;
  lams = linspace(0,1,M);
  for i = 1:M
     xstar = opt(lams(i));
     f1x = f1(xstar(1), xstar(2));
     f2x = f2(xstar(1), xstar(2));
     plot(f1x, f2x,'bo','MarkerFaceColor','b','MarkerSize',5)
  end

  plt2 = plot(f1x, f2x,'bo','MarkerFaceColor','b','MarkerSize',5, ...
       'DisplayName','weighted sum');
  legend([plt1, plt2], 'Location', 'best');



      
end
