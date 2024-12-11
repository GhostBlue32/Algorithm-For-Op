function q = dominates(p1, p2, f1, f2)
  % Inputs:
  % p1 = [x1,y1]  % [x,y] point in design space.
  % p2 = [x2,y2]  % [x,y] point in design space.
  % f1 = obj fcn f1(x,y)
  % f2 = obj fcn f2(x,y)
  % Returns:
  % q = true if point p1 dominates point p2, false otherwise.

  % We assume 2D design space p = [x, y], and 
  % 2D objective space [f1, f2].  Then:
  % point p1 dominates p2 if:
  % all(f1(p1) <= f1(p2) && f2(p1) <= f2(p2))
  % and
  % any(f1(p1) < f1(p2) || f2(p1) < f2(p2))
    
  x1 = p1(1);
  y1 = p1(2);
  x2 = p2(1);
  y2 = p2(2);
  
%  fprintf('[x1,y1] = [%f,%f], [x2,y2] = [%f,%f] ...\n', x1,y1,x2,y2)
%  fprintf('f1(p1)=%3f, f1(p2)=%3f, f2(p1)=%3f, f2(p2)=%3f\n', ...
%	 f1(x1,y1), f1(x2,y2), f2(x1,y1), f2(x2,y2))
    
  q1 = all(f1(x1,y1) <= f1(x2,y2) && f2(x1,y1) <= f2(x2,y2));
  q2 = any(f1(x1,y1) < f1(x2,y2) || f2(x1,y1) < f2(x2,y2));
  
  q = q1 && q2;

%  fprintf('q1 = %d, q2 = %d, q = %d\n', q1, q2, q)
%  fprintf('-------------------------- \n')
  
end
