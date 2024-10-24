function X = gradient_descent(lfcn, lgrad, X0, tol)
  % This is the implementation of gradient descent for optimizing a scalar
  % fcn having multiple inputs.  This version uses initial alpha=1
  % followed by backtracking.

  % Armijo's rule parameter -- sets desired decrease of obj fcn.
  c1 = .01; 
    
  % Initialize algorithm
  X = X0;

  % Do optimization in a loop to prevent infinite loops
  % from nonconvergence
  for i = 1:4000
    % Compute the fcn here
    fx = lfcn(X);

    % Get the gradient at point X.  This is the direction to step in.
    gn = lgrad(X);

    % Now do line search using backtracking.  Use Armijo's rule to
    % validate step length.
    % Initialize step distance for backtracking
    alpha = 1;
    fxstep = lfcn(X - alpha*gn);

    % Iterate until Armijo's rule is satisfied.
    flag = 0;
    for j=1:25
      %fprintf('Armijo iteration %d ...\n', j)
      if ( fxstep >= fx - c1 * alpha * norm(gn) )
        alpha = alpha/2;  % Shrink step.
        fxstep = lfcn(X - alpha*gn);
      else 
        flag = 1;
        %fprintf('Done with Armijo\n')
        break;
      end
    end
    
    % Check if rule was satisfied.
    %if (flag==0)
    %  error('Armijos rule failed!')
    %end
    
    % Update X using the value of alpha we found.
    X = X - alpha*gn;


    % Check if we're close enough to quit yet.  
    % Use Norm(Gradient(f)) < tol as stopping sign
    if (norm(lgrad(X)) < tol)
      fprintf('Terminating after %d iterations.\n', i)
      return
    end

 
  end  % end of for loop

%error('Terminated without convergence!\n')
end
