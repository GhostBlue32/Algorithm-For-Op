function [Wnp1, Hnp1] = Coordinate_descent(A, W0, H0, tol)
  % Coordinate descent used for NMF.  
  % A is the matrix to decompose.  The initial guesses are matrices W0 and H0.

  Wn = W0;
  Hn = H0;
  [wr, wc] = size(Wn);
  [hr, hc] = size(Hn);

  for it = 1:500000
      Wnp1 = Wn;
      Hnp1 = Hn;
      % Compute matrix R
      R = A - Wn * Hn;% Check for convergence
      

      %---------------------------    
      % Update Wn
      HH = Hn * Hn';
      for i = 1:wr
          for j = 1:wc
              Rht = sum(R(i, :) .* Hn(j, :));
              s = max(-Wn(i, j), Rht / HH(j, j));
              Wnp1(i, j) = Wn(i, j) + s;
              R(i, :) = R(i, :) - s * Hn(j, :);
          end
      end
      %---------------------------
      % Update Hn
      WW = Wnp1' * Wnp1;
      for i = 1:hr
          for j = 1:hc
              Wtr = sum(Wnp1(:, i) .* R(:, j));
              s = max(-Hn(i, j), Wtr / WW(i, i));
              Hnp1(i, j) = Hn(i, j) + s;
              R(:, j) = R(:, j) - s * Wnp1(:, i);
          end
      end
      % Check for convergence
      if (norm(Wn - Wnp1) < tol && norm(Hn - Hnp1) < tol)
          fprintf('Converged after %d iterations.\n', it)
          return
      end

        
      

      % Update Wn and Hn for the next iteration
      Wn = Wnp1;
      Hn = Hnp1;
  end  % end of for loop

  error('Non-negative matrix factorization terminated without convergence!\n')
end
