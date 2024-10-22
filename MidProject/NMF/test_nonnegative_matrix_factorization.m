function test_nonnegative_matrix_factorization()

  tol = 1e-3;

  % Target matrix is nonnegative.
  r = 8;  % Numrows
  c = 5;  % Numcols
  
  sum_my = 0;
  test_time = 20;
  total_norm = 0;
  avg_norm = 0;
  for iter = 1:test_time
    A = 10*rand(r,c);
    
    % fprintf('A = \n')
    % disp(A)
    
    % fprintf('norm(A, fro) = \n')
    % disp(norm(A, 'fro'))
    
    p = 3;
    W0 = 5*rand(r,p);
    H0 = 5*rand(p,c);
    
    [W,H] = nonnegative_matrix_factorization(A, W0, H0, tol);
    
    % fprintf('W = \n')
    % disp(W)
    
    % fprintf('H = \n')
    % disp(H)
    
    % fprintf('W*H = \n')  
    % disp(W*H)
    sum_my = sum_my + (norm(W*H-A, 'fro'));
    total_norm = total_norm + norm(A, 'fro');
    avg_norm = avg_norm + (norm(W*H-A, 'fro')) / norm(A, 'fro');
    % fprintf('norm(W*H - A, fro) = \n')  
    % disp(norm(W*H-A, 'fro'))
    
    
    % [W, H] = nmfLin(A, W0, H0, tol);
    % fprintf('W = \n')
    % disp(W)
    % 
    % fprintf('H = \n')
    % disp(H)
    % 
    % fprintf('W*H = \n')  
    % disp(W*H)
    
    % fprintf('norm(W*H - A, fro) = \n')  
    % disp(norm(W*H-A, 'fro'))
  
  end
  fprintf('The average norm is %f\n', sum_my / test_time);
  fprintf('The average total A norm is %f\n', total_norm / test_time);
  fprintf('The average relative norm is %f\n', avg_norm / test_time);
end
