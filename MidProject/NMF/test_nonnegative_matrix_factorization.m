function test_nonnegative_matrix_factorization()

  tol = 1e-4;

  % Target matrix is nonnegative.
  r = 8;  % Numrows
  c = 5;  % Numcols
  A = 10*rand(r,c);

  fprintf('A = \n')
  disp(A)

  fprintf('norm(A, fro) = \n')
  disp(norm(A, 'fro'))
  
  p = 3;
  W0 = 5*rand(r,p);
  H0 = 5*rand(p,c);

  [W,H] = nonnegative_matrix_factorization(A, W0, H0, tol);

  fprintf('W = \n')
  disp(W)
  
  fprintf('H = \n')
  disp(H)
  
  fprintf('W*H = \n')  
  disp(W*H)
  
  fprintf('norm(W*H - A, fro) = \n')  
  disp(norm(W*H-A, 'fro'))
  
end
