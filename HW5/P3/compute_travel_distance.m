function l = compute_travel_distance(C, V, T)
  %
  % Inputs:
  % C = List of city names to visit.
  % V = order in which to visit them.
  % T = table of distances from one city to the other.
  %
  % Output:
  % l = Total travel distance when all cities are visited in
  % the order specified in V.  We always start and stop
  % at the same city, C{1}.  Note that we have
  % V{1} == V{N+1} where N = length(C) = number of cities.
    
  % Compute travel distance for this visiting order of cities.
  l = 0;
  for i=1:length(C)
    j = get_idx(C, V{i});
    k = get_idx(C, V{i+1});
    l = l+T(j,k);
  end

end
