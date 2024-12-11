function [x, fval] = simplex_basic(A, b, c)
  % This finds x which maximizes the objective fcn fval = c'*x.
  % This program uses a basic implementation of the simplex
  % algo.  Inputs:
  % A = matrix of constraint coeffs.
  % b = constraint values.
  % c = objective fcn coeffs.

  tol = 1e-10;     % Used for testing
  max_iter = 10;
  format short
  
  % Initialize the simplex tableau.  I follow the tableau shown
  % in my slides:  First row is objective fcn, next rows
  % contain the constraint coeffs.  The cols are:
  % decision vars, slack vars, f, b.
  Nr = size(A,1);  % Row count of A (num constraints)
  Nc = size(A,2);  % Col count of A (num decision vars)
  T = [-c', zeros(1,Nr), 1, 0;
       A, eye(Nr,Nr), zeros(Nr,1), b];
  
  fprintf('Initial tableau = \n')
  disp(T)  

  % Perform the simplex iterations
  cnt = 0;
  while any(T(1, 1:end-2) < 0)

    cnt = cnt+1;
    if (cnt > max_iter)
      error('Failed to converge!')
    end
    
    % Find entering variable -- most negative value on top row.
    % This gives us the pivot col.
    [~, pivot_col] = min(T(1, 1:end-2));

    % Find pivot row using ratio test -- 
    % Divide the last column by pivot column 
    % for each corresponding entry except top row and 
    % negative entries. Choose the smallest positive result. 
    % The corresponding row is the pivot row. 
    minr = inf;
    for i=2:Nr+1  % Iterate on rows 2 to end
      %fprintf('Doing ratio test on row %d\n', i)
      %disp(T(i,pivot_col))
      if (T(i,pivot_col) > tol)       % Check for positive.
	r = T(i,end)/T(i,pivot_col);  % Compute ratio	
	if (r < minr)                 % Check for min ratio
	  minr = r;                   % Update if needed.
	  imin = i;
	end
      end
    end
    pivot_row = imin;     % Save out index of pivot row.

    % Get pivot element and use it to normalize the leaving row.
    pivot = T(pivot_row, pivot_col);
    fprintf('pivot_col = %d, pivot_row = %d, pivot = %f\n', ...
	    pivot_col, pivot_row, pivot)
    
    % Normalize the pivot row.  This places 1 in col pivot_col.
    T(pivot_row, :) = T(pivot_row, :) / pivot;
    % Clear out the pivot col in all other rows.
    for i = 1:Nr+1
      if i ~= pivot_row
	T(i,:) = -T(i,pivot_col)*T(pivot_row,:) + T(i,:);
      end
    end
    
  end
  fprintf('Final tableau = \n')
  disp(T)
  % Extract the optimal solution -- it is given by the 
  % transformed A matrix and b column.
  At = T(2:Nr+1, 1:Nc);
  bt = T(2:Nr+1,end);
  
  x = At\bt;
  fval = c'*x;
end

