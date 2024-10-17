function P = make_cities(N)
  % Input = N = number of cities to make
  % Output = 2xN matrix of (x,y) coords of cities.
    
  % We make cities in a domain measuring 200x200 miles.
    
  P = 200*rand(2,N) - 100;

end

