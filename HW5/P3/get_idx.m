function i = get_idx(C, n)
  % This fcn returns the numerical index i of the
  % city named n in the cell array of cities C.
  % Right now I use stupid linear search.  Later I
  % should use some sort of hashing algorithm.
    
  for j = 1:length(C)
    if (strcmp(n, C{j}))
      % Found it
      i = j;
      return
    end
  end
  % If we get here it's an error
  error('Did not find name %s in list of cities', n)
end

