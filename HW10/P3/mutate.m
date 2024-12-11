function cout = mutate(cin)
  % This introduces random mutations in all the children.
  % The mutations help the population explore the entire 
  % search space.
    
  N = size(cin,1);
  cout = zeros(N,2);
  
  amp = 0.02;  % Amplitude of mutations.  Smaller = fewer mutations.
  
  for idx = 1:N
    child = cin(idx,:);
    mut = amp*randn(1,2);
    child = child + mut;
    % Make sure children stay inside feasible set
    cout(idx,:) = [mod(child(1),4), mod(child(2),4)];    
  end
  
end
  
    