function children = crossover(N, parents)
  % This returns N children created by combining the DNA
  % of the parents.  In the real value case, this is done
  % by interpolating a random point between the two parents.

  children = zeros(N,2);  % Number of children to create.
  M = size(parents,1);  % Number of parents
  for cnt = 1:N

    % Randomly select two parents
    i = randi(M,1);
    j = randi(M,1);
    % Don't allow i == j -- try again until i != j
    while (i == j)
      j = randi(M,1);
    end
    par1 = parents(i,:);
    par2 = parents(j,:);
    
    % Make random number in range [0,1] as the interpolation
    % value
    eta = rand();
    
    % Make child from parents
    child = (1-eta)*par1 + eta*par2;

    % Put child into new population.
    children(cnt,:) = child;
  end
  
end

