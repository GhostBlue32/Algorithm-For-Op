function parents = select(f, P)
  % This selects the lower 1/2 of the population P based on
  % objective fcn value.
  %
  % Inputs:
  % f = handle to obj fcn.  Obj fcn takes 2 input args, [x,y].
  % P = population as Nx2 matrix.
  % Outputs:
  % parents = matrix of individuals who can be parents.
    
  % Compute fitness values for each member of the population.
  % In this case, lower values are 'fitter'.
  N = size(P, 1);
  fit = zeros(N,1);
  for i = 1:N
    pp = P(i,:);
    fit(i) = f(pp(1), pp(2));
  end
  
  % Normalize fitness values
  fitu = fit/sum(fit);
  
  % Now sort individuals by fitness.
  % Smallest values come first.
  [fits, idx] = sort(fitu);

  % Parents are first 1/2 of population.
  cutoff = floor(N/2);
  parents = P(idx(1:cutoff), :);

end
