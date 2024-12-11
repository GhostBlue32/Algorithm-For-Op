function P = genetic_algo(f, P, kmax)
  % Inputs:
  % f = handle to obj fcn.
  % P = initial population -- Nx2 matrix of [x,y] pairs.
  % kmax = max number of iterations.
  %
  % Output:
  % x = [x1,x2] vector of mean population values at end of run.
  
  % Members of the population are represented by real
  % [x,y] pairs

    
  % The entire population is an Nx2 matrix of double.
  N = size(P,1);
  for cnt = 1:kmax
    
    % First select good parents from the entire population.
    % The selection criterion is the objective fcn.
    parents = select(f, P);
    
    % Next create children by interpolation.
    % Create N children.
    children = crossover(N, parents);
    
    % Now mutate the children by adding random 
    % noise to each individual.
    children = mutate(children);
    
    % Update the population
    P = children;
  end

end

  
  
  