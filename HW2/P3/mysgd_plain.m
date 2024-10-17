function ustar = mysgd_plain( x, u0, tol )
  % My version of the stochastic gradient descent algorithm.  Implementation
  % is meant to exemplify points made in my note about MLE, GD, and
  % SGD.
  % This is the plain-vanilla version -- no momentum or other tricks
  % to make it converge.  The convergence criterion involves looking
  % at the filtered size of the objective fcn, and stopping when the
  % change in the objective fcn descreases below some tol.
  %
  % Inputs:
  % x -- data vectors.
  % u0 -- starting point for iteration, u0(1) for k, u0(2) for lambda
  % tol -- stopping tolerance.
  %
  % Outputs:
  % ustar -- approximate minimum point found by iteration.
  
  % batch size
  batch_size = 50;
  % Learning rate.
  eta = .00002;
    
  % Start point
  un = u0;

  % Filter value and initial filtered obj fcn value
  alpha = 0.02;
  gfn = L(x(1), un(1), un(2));
  
  N = length(x);

   % Iterate over epochs.
  for epoch = 1:1000

    % Shuffle input data at start of each epoch
    idx = randperm(N);
    xs = x(idx);  
    
    % Iterate over mini-batches
    for i = 1:batch_size:N
      % Ensure we don't exceed dataset size for last batch
      batch_end = min(i + batch_size - 1, N);
      batch_x = xs(i:batch_end);  % Mini-batch of data points
      

      % Initialize gradient sum for this mini-batch
      [pk, pl] = L_grad(batch_x, un(1), un(2));
      % Compute average gradient over the mini-batch
      gn = [sum(pk), sum(pl)];
      
      % Update step
      step = eta * gn;
      unp1 = un + step;

      % Compute the Loss of all element in the badge
      L_sum = 0;
      for j = 1:length(batch_x)
          L_sum = L_sum + L(batch_x(j), unp1(1), unp1(2));
      end
      L_avg = L_sum / length(batch_x);

      % Compute filtered objective function here, using unp1
      gfnp1 = alpha * L_avg + (1 - alpha) * gfn;
     
      % Convergence test -- check if change in the filtered objective function is below tolerance
      if (norm(gfnp1 - gfn) < tol )
        fprintf('Converged at %d epoch, %d step.\n', epoch, i)
        ustar = unp1;
        return
      end

      % Move variables back one step for next iteration.
      un = unp1;
      gfn = gfnp1;
    end
  end  
  % If we get here it's because the algorithm didn't converge.
  %error('mysgd_plain failed to converge!');
  ustar = unp1;
end

